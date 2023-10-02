//
//  LocalCacheForMapItems.swift
//  SnapScape
//
//  Created by Jigar Thakkar on 2/10/2023.
//

import Foundation
import MapKit

actor LocalCacheForMapItems {
    
    public static let shared = LocalCacheForMapItems()
    
    private var localCacheOfMapItemsWithDistance = Set<MapItem>()
    
    public func getDistanceInAscendingOrder(userLocation: CLLocationCoordinate2D,
                                            mapItems: [MapItem]) async -> [MapItem] {
        let currentMapItems = Set(mapItems)
        let newMapItems = currentMapItems.subtracting(localCacheOfMapItemsWithDistance)
        let backToArray = Array(newMapItems)
        let allMapItemsWithDistances = await getAllDistances(mapItems: backToArray,
                                                             userLocation: userLocation)
        for eachMapItem in allMapItemsWithDistances {
            localCacheOfMapItemsWithDistance.insert(eachMapItem)
        }
        let arrayToShort = Array(localCacheOfMapItemsWithDistance)
        let shorted = arrayToShort.shortByDistance()
        return shorted
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
