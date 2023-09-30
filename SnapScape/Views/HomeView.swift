//
//  HomeView.swift
//  SnapScape
//
//  Created by Jigar Thakkar on 27/9/2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            TabView {
                MapView()
                    .tabItem {
                        Label("Map", systemImage: "map")
                    }
                ListView()
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
