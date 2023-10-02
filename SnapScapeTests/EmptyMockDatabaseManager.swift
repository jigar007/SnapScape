//
//  EmptyMockDatabaseManager.swift
//  SnapScapeTests
//
//  Created by Jigar Thakkar on 2/10/2023.
//

import Foundation
@testable import SnapScape

class EmptyMockDatabaseManager: DatabaseProvider {
    func fetchMapItems() throws -> [SnapScape.MapItem] {
        []
    }
    
    func addMapItem(_ mapItem: SnapScape.MapItem) throws {}
    
    func saveData() throws {}
}
