//
//  DistanceCalculator.swift
//  SnapScape
//
//  Created by Jigar Thakkar on 30/9/2023.
//

import Foundation
import MapKit

enum MapItemWithDistance {
    case mapItems([MapItem])
    case calculationInProgress
    case userLocationIsNoAvailable
}

@Observable
class DistanceCalculator {
    
    public var mapItemsWithDistance: MapItemWithDistance = .calculationInProgress
    
    public func getDistanceInAscendingOrder(userLocation: CLLocation?,
                                     mapItems: [MapItem]) async {
        guard let userLocation else {
            mapItemsWithDistance = .userLocationIsNoAvailable
            return
        }
        let allDistances = await getAllDistances(mapItems: mapItems, userLocation: userLocation.coordinate)
        let shorted = allDistances.shortByDistance()
        mapItemsWithDistance = .mapItems(shorted)
    }
    
    
    private func getAllDistances(mapItems: [MapItem],
        userLocation: CLLocationCoordinate2D) async -> [MapItem] {
        await mapItems.concurrentCompactMap { mapItem in
            if let distance = await self.getDistance(from: mapItem, to: userLocation) {
                return mapItem.setDistance(distance)
            } else {
                return nil
            }
        }
    }
    
    private func getDistance(from mapItem: MapItem,
                     to userLocation: CLLocationCoordinate2D) async ->  CLLocationDistance? {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation))
        request.destination = mapItem.mkMapItem
        let directions = MKDirections(request: request)
        let response = try? await directions.calculateETA()
        return response?.distance
    }
}
