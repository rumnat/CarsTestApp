//
//  CarsRequest.swift
//  TestApp
//
//  Created by Anton Muratov on 11/8/18.
//  Copyright © 2018 Anton Muratov. All rights reserved.
//

import Foundation

struct CarsRequest: Request {
    typealias ParseableModel = DataList<Car>
    
    var path: String? {
        return "locations"
    }
}
