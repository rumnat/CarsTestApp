//
//  ApiServiceError.swift
//  TestApp
//
//  Created by Anton Muratov on 11/8/18.
//  Copyright © 2018 Anton Muratov. All rights reserved.
//

import Foundation

enum ApiServiceError: LocalizedError {
    case emptyData
    case mappingImpossible(Any)
    case invalidUrl
    case custom(String)
    
    var localizedDescription: String {
        switch self {
        case .emptyData: return "Response data is empty"
        case .mappingImpossible(let model): return "\(model) can't be mapped"
        case .invalidUrl: return "Url is invalid"
        case .custom(let customErrorMessage): return  customErrorMessage
        }
    }
}
