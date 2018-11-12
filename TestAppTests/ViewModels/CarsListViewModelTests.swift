//
//  CarsListVIewModelTests.swift
//  TestAppTests
//
//  Created by Anton Muratov on 11/8/18.
//  Copyright © 2018 Anton Muratov. All rights reserved.
//

import XCTest
import RxSwift
import NetworkExtension

@testable import TestApp

class CarsListVIewModelTests: XCTestCase {
    var carsRepository: CarsRepositoryMock!
    var carsListCoodinator: CarsListCoordinatorMock!
   var carsListViewModel: CarsListViewModel!
    
    override func setUp() {
        super.setUp()
        carsRepository = CarsRepositoryMock()
        carsListCoodinator = CarsListCoordinatorMock()
        carsListViewModel = CarsListViewModel(carsRepository, carsListCoodinator)
    }

    func testListItemClick() {
        carsListViewModel.listViewItemSelected.onNext(IndexPath(row: 0, section: 0))
        XCTAssertTrue(carsListCoodinator.showMapWasInvoked)
    }
}
