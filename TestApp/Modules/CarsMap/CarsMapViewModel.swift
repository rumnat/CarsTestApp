//
//  CarsMapViewModel.swift
//  TestApp
//
//  Created by Anton Muratov on 11/8/18.
//  Copyright © 2018 Anton Muratov. All rights reserved.
//

import RxSwift
import RxCocoa

class CarsMapViewModel {
    private let carsRepository: CarsRepositoryType
    private let disposeBag = DisposeBag()
    
    private let coordinatesSubject = BehaviorSubject<[Coordinate]>(value: [])
    
    // MARK: - Outputs
    
    let coordinates: Observable<[Coordinate]>
    
    // MARK: - Inits
    
    init(_ carsRepository: CarsRepositoryType) {
        self.carsRepository = carsRepository
        self.coordinates = coordinatesSubject.asObservable()
        
        loadVehicles()
    }
    
    // MARK: - Private
    
    // MARK: - Requests
    
    private func loadVehicles() {
        carsRepository
            .fetchCars()
            .map { $0.map { Coordinate(latitude: $0.latitude, longitude: $0.longitude) } }
            .subscribe(onNext: {
                self.coordinatesSubject.onNext($0)
            })
            .disposed(by: disposeBag)
    }
}
