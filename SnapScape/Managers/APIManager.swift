//
//  APIManager.swift
//  SnapScape
//
//  Created by Jigar Thakkar on 29/9/2023.
//

import Foundation

protocol RemoteLocationProvider {
    func fetchLocations() async throws -> [Location]
}

class APIManager: RemoteLocationProvider {
    
    private let url: URL
    
    init(url: URL = Constants.API_URL) {
        self.url = url
    }
    
    public func fetchLocations() async throws -> [Location] {
        let (data, response) = try await URLSession.shared.data(from: url)
        let fetchedData = try JSONDecoder().decode(APIResponse.self,
                                                   from: try mapResponse(response: (data,response)))
        return fetchedData.locations
    }
}
