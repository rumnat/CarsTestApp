//
//  Logger.swift
//  TestApp
//
//  Created by Anton Muratov on 11/8/18.
//  Copyright © 2018 Anton Muratov. All rights reserved.
//

import SwiftyBeaver

let log = Logger.create()

class Logger {
    fileprivate class func create() -> SwiftyBeaver.Type {
        let log = SwiftyBeaver.self
        log.addDestination(ConsoleDestination())
        return log
    }
}
