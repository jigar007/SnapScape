//
//  MockAPIManager.swift
//  SnapScapeTests
//
//  Created by Jigar Thakkar on 2/10/2023.
//

import Foundation
@testable import SnapScape

class MockAPIManager: RemoteLocationProvider {
    
    private let milsonsPoint = Location(name: "Milsons Point", latitude: -33.85075, longitude: 151.212519)
    private let bondiBeach = Location(name: "Bondi Beach", latitude: -33.889967, longitude: 151.27644)
    private let circularQuay = Location(name: "Circular Quay", latitude: -33.860178, longitude: 151.212706)
    private let manlyBeach = Location(name: "Manly Beach", latitude: -33.797151, longitude: 151.288784)
    private let darlingHarbour = Location(name: "Darling Harbour", latitude: -33.873379, longitude: 151.20094)
    
    func fetchLocations() async throws -> [SnapScape.Location] {
        [milsonsPoint, bondiBeach, circularQuay, manlyBeach, darlingHarbour]
    }
}
