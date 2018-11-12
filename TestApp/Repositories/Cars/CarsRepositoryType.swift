//
//  CarsRepositoryType.swift
//  TestApp
//
//  Created by Anton Muratov on 11/8/18.
//  Copyright © 2018 Anton Muratov. All rights reserved.
//

import RxSwift

protocol CarsRepositoryType {
    func fetchCars() -> Observable<[Car]>
}
