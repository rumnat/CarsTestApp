//
//  AppFlowCoordinator.swift
//  TestApp
//
//  Created by Anton Muratov on 11/8/18.
//  Copyright © 2018 Soft Serve. All rights reserved.
//

import UIKit

class AppFlowCoordinator {
    private let window: UIWindow
    private let apiService: ApiService
    
    private var mainFlowCoordinator: MainFlowCoordinator?
    
    // MARK: - Init
    
    init(window: UIWindow, apiService: ApiService) {
        self.apiService = apiService
        self.window = window
    }
    
    // MARK: - Flow control
    
    func start() {
        startMainFlow()
        window.makeKeyAndVisible()
    }
    
    func startMainFlow() {
        log.verbose("Start main flow")
        
        let mainRouter = MainRouter()
        mainFlowCoordinator = MainFlowCoordinator(
            router: mainRouter,
            appFlowCoordinator: self,
            apiService: apiService
        )
        
        mainFlowCoordinator?.start()
        window.rootViewController = mainRouter.rootController
    }
}
