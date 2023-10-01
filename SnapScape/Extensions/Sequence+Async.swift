//
//  Sequence+Async.swift
//  SnapScape
//
//  Created by Jigar Thakkar on 1/10/2023.
//

import Foundation

extension Sequence {
    func concurrentCompactMap<T>(
        withPriority priority: TaskPriority? = nil,
        _ transform: @escaping (Element) async -> T?
    ) async -> [T] {
        let tasks = map { element in
            Task(priority: priority) {
                await transform(element)
            }
        }
        
        return await tasks.asyncCompactMap { task in
            await task.value
        }
    }
    
    func asyncCompactMap<T>(
        _ transform: (Element) async throws -> T?
    ) async rethrows -> [T] {
        var values = [T]()
        
        for element in self {
            guard let value = try await transform(element) else {
                continue
            }
            
            values.append(value)
        }
        
        return values
    }
}
