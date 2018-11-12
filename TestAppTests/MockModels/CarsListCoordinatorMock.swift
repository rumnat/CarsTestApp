//
//  CarsListCoordinatorMock.swift
//  TestAppTests
//
//  Created by Anton Muratov on 11/8/18.
//  Copyright © 2018 Anton Muratov. All rights reserved.
//

@testable import TestApp

class CarsListCoordinatorMock: VehicleListCoordinatorType {
    var showMapWasInvoked = false
    
    func showMap() {
        showMapWasInvoked = true
    }
}
