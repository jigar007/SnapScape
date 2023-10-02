//
//  LocationDetailView.swift
//  SnapScape
//
//  Created by Jigar Thakkar on 27/9/2023.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    
    public var mapItem: MapItem
    public var saveNotes: () -> Void
    
    @State private var notes: String = ""
    
    private var mapCameraPosition: MapCameraPosition {
        .camera(MapCamera(centerCoordinate: mapItem.coordinates,
                          distance: 1000,
                          heading: 270,
                          pitch: 70))
    }
    
    var body: some View {
        VStack {
            Map(position: .constant(mapCameraPosition)) {
                Marker(item: mapItem.mkMapItem)
            }
            .frame(height: 300)
            .mapStyle(.standard(elevation: .realistic))
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Label("Notes", systemImage: "list.clipboard")
                        .padding(.bottom)
                    Spacer()
                    Button("Save") {
                        mapItem.notes = notes
                        saveNotes()
                    }
                    .padding(6)
                    .background(Color(uiColor: .systemBlue))
                    .cornerRadius(3.0)
                    .foregroundColor(.white)
                }
                VStack {
                    TextEditor(text: $notes)
                        .frame(height: 100)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.accentColor, lineWidth: 1)
                )
            }
            .padding()
            Spacer()
        }
        .onAppear {
            notes = mapItem.notes
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(mapItem.name)
            }
        }
    }
}

#Preview {
    let mapItem = MapItem(name: "Milsons Point",
                          notes: "",
                          latitude: -33.85075,
                          longitude: 151.212519)
    return LocationDetailView(mapItem: mapItem, saveNotes: {})
}
