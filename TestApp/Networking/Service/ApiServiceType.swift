//
//  ApiServiceType.swift
//  TestApp
//
//  Created by Anton Muratov on 11/8/18.
//  Copyright © 2018 Anton Muratov. All rights reserved.
//

import RxSwift

protocol ApiServiceType {
    func execute<T: Request>(_ request: T) -> Completable
    func execute<T: Request>(_ request: T) -> Observable<T.ParseableModel>
}
