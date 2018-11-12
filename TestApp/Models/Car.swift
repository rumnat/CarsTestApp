//
//  Car.swift
//  TestApp
//
//  Created by Anton Muratov on 11/8/18.
//  Copyright © 2018 Anton Muratov. All rights reserved.
//

struct Car {
    let id: Int
    let latitude: Double
    let longitude: Double
    let isOnTrip: Bool
}

extension Car: Decodable {
    private enum Key: CodingKey {
        case id, latitude, longitude, isOnTrip
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.latitude = Double(try container.decode(String.self, forKey: .latitude)) ?? 0.0
        self.longitude = Double(try container.decode(String.self, forKey: .longitude)) ?? 0.0
        self.isOnTrip = try container.decode(Bool.self, forKey: .isOnTrip)
    }
}
