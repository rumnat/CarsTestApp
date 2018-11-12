//
//  CarsRepositoryMock.swift
//  TestAppTests
//
//  Created by Anton Muratov on 11/8/18.
//  Copyright © 2018 Anton Muratov. All rights reserved.
//

@testable import TestApp
@testable import RxSwift

class CarsRepositoryMock: CarsRepositoryType {
    var result: Observable<[Car]>?
    
    func fetchCars() -> Observable<[Car]> {
        return result ?? Observable.just([])
    }
}
