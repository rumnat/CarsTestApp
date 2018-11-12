//
//  CarsListViewModel.swift
//  TestApp
//
//  Created by Anton Muratov on 11/8/18.
//  Copyright © 2018 Anton Muratov. All rights reserved.
//

import RxSwift
import RxCocoa
import CoreLocation

extension CarsListViewModel {
    struct ListViewItem {
        fileprivate let isOnTrip: Bool
        let rotationAngle: CGFloat
        var title: String {
            return "The car is" + (isOnTrip ? "" : " not") + " on trip"
        }
    }
}

extension CarsListViewModel {
    enum State {
        case empty
        case loading
        case loaded
        case failed(String)
    }
}

class CarsListViewModel {
    // MARK: - Dependencies
    private let carsRepository: CarsRepositoryType
    private weak var coordinator: VehicleListCoordinatorType?
    private let locationManager = CLLocationManager()
    
    private let disposeBag = DisposeBag()
    private var cars: [Car] = []
    
    // MARK: - Internal subjects
    
    private let stateSubject = BehaviorSubject<State>(value: .empty)
    private let viewItemsSubject = BehaviorSubject<[ListViewItem]>(value: [])
    
    // MARK: - Inputs
    
    let listViewItemSelected: PublishSubject<IndexPath> = .init()
    
    // MARK: - Outputs
    
    let state: Observable<State>
    let viewItems: Observable<[ListViewItem]>
    
    // MARK: - Init
    
    init(_ carsRepository: CarsRepositoryType, _ coordinator: VehicleListCoordinatorType? = nil) {
        self.carsRepository = carsRepository
        self.coordinator = coordinator
        
        self.state = stateSubject.asObservable()
        self.viewItems = viewItemsSubject.asObservable()
        
        setupLocationManager()
        setupListViewItemSelection()
        loadVehicles()
    }
    
    // MARK: - Congiguration
    
    private func setupLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        locationManager.rx.didChangeAuthorization
            .subscribe(onNext: { [weak locationManager] (_, status) in
                guard status == .authorizedWhenInUse else { return }
                locationManager?.startUpdatingLocation()
            })
            .disposed(by: disposeBag)
        
        locationManager.rx.location
            .map { (location) in
                self.cars.map {
                    let rotationAngle = CGFloat(atan2f(
                        Float($0.latitude - (location?.coordinate.latitude ?? 0)),
                        Float($0.longitude - (location?.coordinate.longitude ?? 0))
                    ))
                    return ListViewItem(isOnTrip: $0.isOnTrip, rotationAngle: rotationAngle)
                }
            }
            .subscribe(onNext: {
                self.viewItemsSubject.onNext($0)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupListViewItemSelection() {
        listViewItemSelected
            .subscribe(onNext: { [unowned self] _ in
                self.coordinator?.showMap()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Requests
    
    private func loadVehicles() {
        carsRepository
            .fetchCars()
            .map { (cars) -> [ListViewItem] in
                self.cars.removeAll()
                self.cars.append(contentsOf: cars)

                return cars.map { ListViewItem(isOnTrip: $0.isOnTrip, rotationAngle: 0) }
            }
            .do(onError: {
                self.stateSubject.onNext(.failed($0.localizedDescription))
            }, onCompleted: {
                self.stateSubject.onNext(.loaded)
            }, onSubscribe: {
                self.stateSubject.onNext(.loading)
            })
            .subscribe(onNext: {
                self.viewItemsSubject.onNext($0)
            })
            .disposed(by: disposeBag)
    }
}
