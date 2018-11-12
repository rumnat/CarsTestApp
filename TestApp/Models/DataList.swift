//
//  DataList.swift
//  TestApp
//
//  Created by Anton Muratov on 11/9/18.
//  Copyright © 2018 Anton Muratov. All rights reserved.
//

import Foundation

struct DataList<T: Decodable>: Decodable {
    let data: [T]
}
