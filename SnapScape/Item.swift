//
//  Item.swift
//  SnapScape
//
//  Created by Jigar Thakkar on 27/9/2023.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
