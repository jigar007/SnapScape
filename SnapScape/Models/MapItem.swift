//
//  MapItem.swift
//  SnapScape
//
//  Created by Jigar Thakkar on 29/9/2023.
//

import SwiftData
import CoreLocation
import MapKit

@Model
class MapItem {
    var name: String
    var notes: String
    
    var latitude: Double
    var longitude: Double
    
    var distance: Double = 0
    
    var coordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var mkMapItem: MKMapItem {
        let placeMark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placeMark)
        mapItem.name = name
        return mapItem
    }
    
    init(name: String, notes: String, latitude: Double, longitude: Double) {
        self.name = name
        self.notes = notes
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func setDistance(_ distance: Double) -> MapItem {
        self.distance = distance
        return self
    }
}
