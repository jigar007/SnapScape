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
    @State private var selectedMapItem: MapItem? = nil
    @State private var showingAlert = false
    @State private var locationName = ""
    @State private var pinCoordinates: CLLocationCoordinate2D? = nil
    @State private var goToLocationDetailScreen = false
    @State private var addLocation = false
    
    private let locationViewModel = LocationViewModel()
        
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            MapReader { reader in
                Map(position: $position, selection: $selectedMapItem) {
                    UserAnnotation()
                    ForEach(locationViewModel.mapItems, id: \.self) { mapItem in
                        Marker(item: mapItem.mkMapItem)
                            .tag(mapItem)
                    }
                    if let pinCoordinates {
                        Marker("NewItem", coordinate: pinCoordinates)
                    }
                }
                .onChange(of: selectedMapItem) {
                    if !addLocation {
                        goToLocationDetailScreen.toggle()
                    }
                }
                .onTapGesture { screenCoord in
                    if addLocation {
                        pinCoordinates = reader.convert(screenCoord, from: .local)
                        showingAlert.toggle()
                    }
                }
                .alert("Enter Title", isPresented: $showingAlert) {
                    TextField("Enter Place Title", text: $locationName)
                    Button("Cancel") {
                        showingAlert.toggle()
                        pinCoordinates = nil
                    }
                    Button("Save") {
                        
                    }
                }
                .mapControls {
                    MapCompass()
                    MapPitchToggle()
                    MapUserLocationButton()
                    MapScaleView()
                }
                .mapStyle(.standard(elevation: .realistic))
            }
            Button {
                addLocation.toggle()
            } label: {
                Label("Add Location", systemImage: addLocation ? "mappin" : "plus")
                    .labelStyle(.iconOnly)
            }
            .padding()
            .background(Color(uiColor: UIColor.systemBackground))
            .cornerRadius(5)
            .padding()
            .padding(.bottom)
        }
        .navigationDestination(isPresented: $goToLocationDetailScreen) {
            if let selectedMapItem {
                LocationDetailView(mapItem: selectedMapItem)
                    .onDisappear {
                        print("hello")
                    }
            }
        }
    }
}

#Preview {
    MapView()
}
