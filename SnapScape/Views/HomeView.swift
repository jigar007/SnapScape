//
//  HomeView.swift
//  SnapScape
//
//  Created by Jigar Thakkar on 27/9/2023.
//

import SwiftUI

struct HomeView: View {
    
    private let locationViewModel = LocationViewModel()
    private let locationManager = LocationManager()

    var body: some View {
        NavigationStack {
            TabView {
                MapView(locationViewModel: locationViewModel)
                    .tabItem {
                        Label("Map", systemImage: "map")
                    }
                ListView(locationViewModel: locationViewModel,
                         locationManager: locationManager)
                    .tabItem {
                        Label("List", systemImage: "list.bullet")
                    }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("SnapScape")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    HomeView()
}
