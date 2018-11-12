//
//  CarsMapViewController.swift
//  TestApp
//
//  Created by Anton Muratov on 11/8/18.
//  Copyright © 2018 Anton Muratov. All rights reserved.
//

import UIKit
import MapKit
import RxSwift

class CarsMapViewController: UIViewController {
    @IBOutlet private weak var mapView: MKMapView!
    
    let annotationViewReuseIdentifier = "AnnotationIdentifier"
    
    var viewModel: CarsMapViewModel?
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerAnnotations()
        bindView()
    }

    // MARK: - Private
    
    // MARK: - Configurations
    
    private func registerAnnotations() {
        mapView.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: annotationViewReuseIdentifier)
    }
    
    private func bindView() {
        viewModel?.coordinates
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (coordinates) in
                let annotations = coordinates.map { (coordinate) -> MKPointAnnotation in
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(
                        latitude: coordinate.latitude,
                        longitude: coordinate.longitude
                    )
                    return annotation
                }
                
                (self?.mapView.annotations).flatMap { self?.mapView.removeAnnotations($0) }
                self?.mapView.addAnnotations(annotations)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - MKMapViewDelegate

extension CarsMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let dequeuedPinView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationViewReuseIdentifier)
        let pinView = dequeuedPinView ?? MKAnnotationView(annotation: annotation,
                                                          reuseIdentifier: annotationViewReuseIdentifier)
        pinView.canShowCallout = true
        pinView.image = #imageLiteral(resourceName: "ic_taxi")
        pinView.annotation = annotation
        return pinView
    }
}
