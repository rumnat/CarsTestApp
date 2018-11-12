//
//  CarsMapViewModelTests.swift
//  TestAppTests
//
//  Created by Anton Muratov on 11/8/18.
//  Copyright © 2018 Anton Muratov. All rights reserved.
//

import XCTest
import TestApp
import RxSwift
import RxBlocking

@testable import TestApp

class CarsMapViewModelTests: XCTestCase {
    var carsRepository: CarsRepositoryMock!
    
    override func setUp() {
        super.setUp()
        carsRepository = CarsRepositoryMock()
    }
    
    func testCordinatesFetcedSuccessfully() throws {
        let cars = [
            Car(id: 1, latitude: 1.0, longitude: 1.0, isOnTrip: true),
            Car(id: 2, latitude: 2.0, longitude: 2.0, isOnTrip: true)
        ]
        
        let coordinates = cars.map { Coordinate(latitude: $0.latitude, longitude: $0.longitude) }
        
        carsRepository.result = Observable.just(cars)
        
        let carsMapViewModel = CarsMapViewModel(carsRepository)
        
        let coordinatesFetchingResult = try carsMapViewModel.coordinates.toBlocking().toArray().flatMap { $0 }
        
        XCTAssertEqual(coordinates, coordinatesFetchingResult)
    }
}
