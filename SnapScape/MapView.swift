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
    @State private var selectedMapFeature: MapFeature? = nil
    @State private var showingAlert = false
    @State private var locationName = ""
    
    var body: some View {
        VStack {
            Map(position: $position, selection: $selectedMapFeature) {
                UserAnnotation()
            }
            .onChange(of: selectedMapFeature) {
                showingAlert.toggle()
                if let locationTitle = selectedMapFeature?.title {
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

#Preview {
    MapView()
}
