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
    func addMapItem(_ mapItem: MapItem) throws
    func saveData() throws
}


class DatabaseManager: DatabaseProvider {
    
    public static let shared = DatabaseManager()
    private init() {}
    
    @MainActor
    private lazy var mainContext: ModelContext? = {
        do {
            let schema = Schema([MapItem.self])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            let container = try ModelContainer(for: schema, configurations: modelConfiguration)
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
    public func addMapItem(_ mapItem: MapItem) throws {
        mainContext?.insert(mapItem)
        try mainContext?.save()
    }
    
    @MainActor
    public func saveData() throws {
        try mainContext?.save()
    }
}
