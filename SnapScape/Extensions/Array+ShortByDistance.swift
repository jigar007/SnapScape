//
//  Array+shortByDistance.swift
//  SnapScape
//
//  Created by Jigar Thakkar on 1/10/2023.
//

import Foundation

extension Array where Element == MapItem {
    func shortByDistance() -> [MapItem] {
        self.sorted { $0.distance < $1.distance }
    }
}

