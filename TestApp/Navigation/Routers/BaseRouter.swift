//
//  BaseRouter.swift
//  TestApp
//
//  Created by Anton Muratov on 11/8/18.
//  Copyright © 2018 Soft Serve. All rights reserved.
//

import UIKit

class BaseRouter: NSObject {
  func present(_ viewController: UIViewController, animated: Bool = true) { }
  func push(_ viewController: UIViewController, animated: Bool = true) { }
  func pop(animated: Bool = true) { }
  func popToRoot(animated: Bool = true) { }
  func root(_ viewController: UIViewController, animated: Bool = true) { }
}
