//
//  DatabaseManager.swift
//  SnapScape
//
//  Created by Jigar Thakkar on 29/9/2023.
//

import Foundation
import SwiftData
import OSLog

protocol DatabaseProvider {
    func fetchMapItems() throws -> [MapItem]
    func addMapItem(_ mapItem: MapItem)
}

class DatabaseManager: DatabaseProvider {
    
    @MainActor
    private lazy var mainContext: ModelContext? = {
        do {
            let container = try ModelContainer(for: MapItem.self)
            let mainContext = container.mainContext
            return mainContext
        }
        catch {
            Logger.runTimeError.critical("\(error.localizedDescription)")
            return nil
        }
    }()
    
    @MainActor
    public func fetchMapItems() throws -> [MapItem] {
        let upcomingTrips = FetchDescriptor<MapItem>()
        return try mainContext?.fetch(upcomingTrips) ?? []
    }
    
    @MainActor
    public func addMapItem(_ mapItem: MapItem) {
        mainContext?.insert(mapItem)
    }
}
