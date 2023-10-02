//
//  MapView.swift
//  SnapScape
//
//  Created by Jigar Thakkar on 27/9/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    public var locationViewModel: LocationViewModel
    
    @State private var position: MapCameraPosition = .userLocation(followsHeading: true, fallback: .automatic)
    @State private var selectedMapItem: MapItem? = nil
    @State private var showingAlert = false
    @State private var locationName = ""
    @State private var pinCoordinates: CLLocationCoordinate2D? = nil
    @State private var goToLocationDetailScreen = false
    @State private var mapItems = [MapItem]()
    @State private var addLocation = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            MapReader { reader in
                Map(position: $position, selection: $selectedMapItem) {
                    UserAnnotation()
                    ForEach(mapItems, id: \.self) { mapItem in
                        Marker(item: mapItem.mkMapItem)
                            .tag(mapItem)
                    }
                    if let pinCoordinates {
                        Marker(locationName, coordinate: pinCoordinates)
                    }
                }
                .onChange(of: locationViewModel.mapItems) {
                    mapItems = locationViewModel.mapItems
                }
                .onAppear {
                    mapItems = locationViewModel.mapItems
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
                        locationName = ""
                        pinCoordinates = nil
                    }
                    Button("Save") {
                        if locationName != "", let pinCoordinates {
                            let mapItem = MapItem(name: locationName, notes: "", coordinates: pinCoordinates)
                            locationViewModel.addMapItem(mapItem: mapItem)
                        }
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
                LocationDetailView(mapItem: selectedMapItem, saveNotes: { locationViewModel.saveNotes() })
            }
        }
    }
}

#Preview {
    MapView(locationViewModel: LocationViewModel())
}
