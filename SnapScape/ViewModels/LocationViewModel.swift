//
//  LocationViewModel.swift
//  SnapScape
//
//  Created by Jigar Thakkar on 29/9/2023.
//

import Foundation
import OSLog

@Observable
class LocationViewModel {
    
    public var mapItems = [MapItem]()
    
    private let databaseProvider: DatabaseProvider
    
    init(remoteLocationProvider: RemoteLocationProvider = APIManager(),
         databaseProvider: DatabaseProvider = DatabaseManager()) {
        self.databaseProvider = databaseProvider
        fetchRemoteLocations(remoteLocationProvider)
        fetchDataBaseLocations()
    }
    
    private func fetchRemoteLocations(_ remoteLocationProvider: RemoteLocationProvider) {
        Task {
            do {
                let locationsFromAPI = try await remoteLocationProvider.fetchLocations()
                let remoteMapItems = locationsFromAPI.map {
                    MapItem(name: $0.name,
                            notes: "",
                            latitude: $0.latitude,
                            longitude: $0.longitude)
                }
                mapItems.append(contentsOf: remoteMapItems)
            } catch {
                Logger.runTimeError.critical("\(error.localizedDescription)")
            }
        }
    }
    
    private func fetchDataBaseLocations() {
        do {
            let mapItemsFromDatabase = try databaseProvider.fetchMapItems()
            mapItems.append(contentsOf: mapItemsFromDatabase)
        } catch {
            Logger.runTimeError.critical("\(error.localizedDescription)")
        }
    }
}
