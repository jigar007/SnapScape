//
//  ListView.swift
//  SnapScape
//
//  Created by Jigar Thakkar on 27/9/2023.
//

import SwiftUI
import MapKit

struct ListView: View {
    
    public var locationViewModel: LocationViewModel
    public let locationManager: LocationManager
    
    private let distanceCalculator = DistanceCalculator()
    
    @State private var selectedMapItem: MapItem?
    
    var body: some View {
        ZStack {
            switch distanceCalculator.mapItemsWithDistance {
            case .calculationInProgress:
                ProgressView()
            case .userLocationIsNoAvailable:
                Label("User location is not available", systemImage: "location")
            case.mapItems(let mapItemsWithDistance):
                List(selection: $selectedMapItem) {
                    HStack {
                        Text("Location")
                        Spacer()
                        Text("Nearest")
                    }
                    .bold()
                    ForEach(mapItemsWithDistance) { mapItem in
                        HStack {
                            Text(mapItem.name)
                            Spacer()
                            Text(String(format: "%.2f KM", mapItem.distance.inKiloMeters))
                            Image(systemName: "chevron.right")
                        }
                        .tag(mapItem)
                        .padding(.vertical, 5)
                    }
                }
                .navigationDestination(item: $selectedMapItem) {
                    LocationDetailView(mapItem: $0, saveNotes: {
                        locationViewModel.saveNotes()
                    })
                }
            }
        }
        .onAppear {
            Task {
                await distanceCalculator.getDistanceInAscendingOrder(userLocation: locationManager.userLocation,
                                                                     mapItems: locationViewModel.mapItems)
            }
        }
    }
}

#Preview {
    ListView(locationViewModel: LocationViewModel(),
             locationManager: LocationManager())
}
