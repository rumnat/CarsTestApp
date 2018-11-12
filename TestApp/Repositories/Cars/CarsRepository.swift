//
//  CarsRepository.swift
//  TestApp
//
//  Created by Anton Muratov on 11/8/18.
//  Copyright © 2018 Anton Muratov. All rights reserved.
//

import RxSwift

class CarsRepository: CarsRepositoryType {
    let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func fetchCars() -> Observable<[Car]> {
        let carsRequest = CarsRequest()
        return apiService
            .execute(carsRequest)
            .map { $0.data }
    }
}
