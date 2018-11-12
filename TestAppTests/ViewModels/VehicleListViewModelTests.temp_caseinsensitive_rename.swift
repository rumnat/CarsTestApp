//
//  VehicleListViewModelTests.swift
//  MyTaxiTestAppTests
//
//  Created by Anton Muratov on 8/13/18.
//  Copyright © 2018 Anton Muratov. All rights reserved.
//

import XCTest
@testable import MyTaxiTestApp

class VehicleListViewModelTests: XCTestCase {
    var vehicleRepository: VehicleRepositoryMock!
    var vehicleMapViewModel: VehicleListViewModel!
    var vehicleListCoodinator: VehicleListCoordinatorMock!
    
    override func setUp() {
        super.setUp()
        vehicleRepository = VehicleRepositoryMock()
        vehicleMapViewModel = VehicleListViewModel(vehicleRepository: vehicleRepository)
        vehicleListCoodinator = VehicleListCoordinatorMock()
        vehicleMapViewModel.coordinator = vehicleListCoodinator
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertEqual(try vehicleMapViewModel.state.value(), VehicleListViewModel.State.empty)
    }
    
    func testLoadedState() {
        let vehicleViewItem = VehicleListViewModel.ListViewItem(title: "Taxi", image: #imageLiteral(resourceName: "ic_single_ride"))
        let vehicle = Vehicle(id: 0, fleetType: .taxi, heading: 0, coordinate: Coordinate(latitude: 0, longitude: 0))
        let vehiclesList = VehiclesList(items: [vehicle])
    
        vehicleRepository.result = (vehiclesList, nil)
        vehicleMapViewModel.viewDidLoad()
        
        XCTAssertEqual(try vehicleMapViewModel.state.value(), VehicleListViewModel.State.loaded)
        XCTAssertTrue(try vehicleMapViewModel.viewItems.value().contains(vehicleViewItem))
    }
    
    func testFailedState() {
        vehicleRepository.result = (nil, nil)
        vehicleMapViewModel.viewDidLoad()
        XCTAssertEqual(try vehicleMapViewModel.state.value(), VehicleListViewModel.State.failed("Some went wrong"))
    }
    
    func testListItemClick() {
        vehicleMapViewModel.listItemDidTap()
        XCTAssertTrue(vehicleListCoodinator.showMapWasCalled)
    }
}
