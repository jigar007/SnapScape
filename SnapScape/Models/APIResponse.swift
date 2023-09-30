//
//  APIResponse.swift
//  SnapScape
//
//  Created by Jigar Thakkar on 30/9/2023.
//

import Foundation

struct APIResponse: Decodable {
    let locations: [Location]
    let updated: String
}

struct Location: Decodable {
    let name: String
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case name
        case latitude = "lat"
        case longitude = "lng"
    }
}
