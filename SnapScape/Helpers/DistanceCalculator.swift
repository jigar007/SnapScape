//
//  DistanceCalculator.swift
//  SnapScape
//
//  Created by Jigar Thakkar on 30/9/2023.
//

import Foundation
import MapKit

enum MapItemWithDistance: Equatable {
    case mapItems([MapItem])
    case calculationInProgress
    case userLocationIsNoAvailable
}

@Observable
class DistanceCalculator {
    
    public var mapItemsWithDistance: MapItemWithDistance = .calculationInProgress
    
    private let localCacheForMapItems = LocalCacheForMapItems.shared
    
    public func getDistanceInAscendingOrder(userLocation: CLLocation?,
                                            mapItems: [MapItem]) async {
        guard let userLocation else {
            mapItemsWithDistance = .userLocationIsNoAvailable
            return
        }
        let mapItems = await localCacheForMapItems.getDistanceInAscendingOrder(userLocation: userLocation.coordinate,
                                                                               mapItems: mapItems)
        mapItemsWithDistance = .mapItems(mapItems)
    }
}
