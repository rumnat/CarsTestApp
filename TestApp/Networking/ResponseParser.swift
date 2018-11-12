//
//  ResponseParser.swift
//  TestApp
//
//  Created by Anton Muratov on 11/8/18.
//  Copyright © 2018 Anton Muratov. All rights reserved.
//

import Foundation

protocol ResponseParser {
    associatedtype ParseableModel
    
    static func parse(_ data: Data) throws -> ParseableModel
}

extension ResponseParser where ParseableModel: Decodable {
    static func parse(_ data: Data) throws -> ParseableModel {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode(ParseableModel.self, from: data)
    }
}
