//
//  MainRouter.swift
//  TestApp
//
//  Created by Anton Muratov on 11/8/18.
//  Copyright © 2018 Soft Serve. All rights reserved.
//

import UIKit.UINavigationController

class MainRouter: BaseRouter {
  private let navigationController: UINavigationController
  
  var topController: UIViewController? {
    return navigationController.viewControllers.last
  }
  
  var rootController: UIViewController {
    return navigationController
  }
  
  // MARK: - Init
  
  override init() {
    self.navigationController = UINavigationController()
  }
  
  // MARK: - Overriding
  
  override func present(_ viewController: UIViewController, animated: Bool = true) {
    navigationController.present(viewController, animated: animated)
  }
  
  override func push(_ viewController: UIViewController, animated: Bool = true) {
    navigationController.pushViewController(viewController, animated: animated)
  }
  
  override func pop(animated: Bool = true) {
    navigationController.popViewController(animated: animated)
  }
  
  override func popToRoot(animated: Bool = true) {
    navigationController.popToRootViewController(animated: animated)
  }
  
  override func root(_ viewController: UIViewController, animated: Bool = true) {
    navigationController.setViewControllers([viewController], animated: animated)
  }
}
