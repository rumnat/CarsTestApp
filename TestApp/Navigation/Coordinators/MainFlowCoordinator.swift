//
//  MainFlowCoordinator.swift
//  TestApp
//
//  Created by Anton Muratov on 11/8/18.
//  Copyright © 2018 Soft Serve. All rights reserved.
//

import UIKit

class MainFlowCoordinator {
    private unowned let appFlowCoordinator: AppFlowCoordinator
    private let router: MainRouter
    
    private let apiService: ApiService
    
    // MARK: - Init
    
    init(router: MainRouter, appFlowCoordinator: AppFlowCoordinator, apiService: ApiService) {
        self.router = router
        self.appFlowCoordinator = appFlowCoordinator
        self.apiService = apiService
    }
    
    // MARK: - Flow control
    
    func start() {
        let carsListViewController = R.storyboard.main.carsListViewController()!
        carsListViewController.viewModel = CarsListViewModel(CarsRepository(apiService: apiService), self)
        router.root(carsListViewController, animated: false)
    }
}

// MARK: - VehicleListCoordinatorType

extension MainFlowCoordinator: VehicleListCoordinatorType {
    func showMap() {
        let carsMapVieController = R.storyboard.main.carsMapViewController()!
        carsMapVieController.viewModel = CarsMapViewModel(CarsRepository(apiService: apiService))
        router.push(carsMapVieController)
    }
}
