//
//  Logger.swift
//  SnapScape
//
//  Created by Jigar Thakkar on 29/9/2023.
//

import OSLog

extension Logger {
    /// Using your bundle identifier is a great way to ensure a unique identifier.
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    /// Logs the view cycles like a view that appeared.
    static let viewCycle = Logger(subsystem: subsystem, category: "viewcycle")
    
    /// All logs related to errors
    static let runTimeError = Logger(subsystem: subsystem, category: "erros")
}
