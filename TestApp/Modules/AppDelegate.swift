//
//  AppDelegate.swift
//  TestApp
//
//  Created by Anton Muratov on 11/8/18.
//  Copyright © 2018 Anton Muratov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private var appCoordinator: AppFlowCoordinator!
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        log.verbose("Application has launched")
        
        appCoordinator = AppFlowCoordinator(
            window: UIWindow(frame: UIScreen.main.bounds),
            apiService: ApiService(baseUrl: Constant.baseUrl)
        )
        appCoordinator.start()
        
        return true
    }
    
}
