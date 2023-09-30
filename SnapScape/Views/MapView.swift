//
//  MapView.swift
//  SnapScape
//
//  Created by Jigar Thakkar on 27/9/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State private var position: MapCameraPosition = .userLocation(followsHeading: true, fallback: .automatic)
    @State private var selectedMapItem: MKMapItem? = nil
    @State private var showingAlert = false
    @State private var locationName = ""
    
    private let locationViewModel = LocationViewModel()
    
    public var mkMapItems: [MKMapItem] {
        locationViewModel.mapItems.map { $0.mkMapItem }
    }
    
    var body: some View {
        VStack {
            NavigationStack {
                MapReader { reader in
                    Map(position: $position, selection: $selectedMapItem) {
                        UserAnnotation()
                        ForEach(mkMapItems, id: \.self) { mapItem in
                            Marker(item: mapItem)
                        }
                    }
                    .onChange(of: selectedMapItem) {
                        showingAlert.toggle()
                        if let locationTitle = selectedMapItem?.name {
                            locationName = locationTitle
                        }
                    }
                    .alert("Enter Title", isPresented: $showingAlert) {
                        TextField("Enter Place Title", text: $locationName)
                        Button("Cancel") {
                            showingAlert.toggle()
                        }
                        Button("Save") {
                            
                        }
                    }
                    .mapStyle(.standard(elevation: .realistic))
                    .mapControls {
                        MapUserLocationButton()
                        MapCompass()
                        MapScaleView()
                    }
                }
            }
        }
    }
}

#Preview {
    MapView()
}
