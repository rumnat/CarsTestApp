//
//  Request.swift
//  CoreDataNetworkLayer
//
//  Created by Anton Muratov on 11/8/18.
//  Copyright © 2018 Anton Muratov. All rights reserved.
//

import Foundation

typealias HTTPHeaders = [String: String]

protocol Request: ResponseParser {
    var path: String? { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var body: [String: Any]? { get }
    var headers: HTTPHeaders? { get }
}

extension Request {
    var path: String? { return nil }
    var method: HTTPMethod { return .get }
    var queryItems: [URLQueryItem]? { return nil }
    var body: [String: Any]? { return nil }
    var headers: HTTPHeaders? { return nil }
}
