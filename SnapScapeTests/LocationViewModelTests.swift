//
//  SnapScapeTests.swift
//  SnapScapeTests
//
//  Created by Jigar Thakkar on 27/9/2023.
//

import XCTest
@testable import SnapScape
import Combine

final class LocationViewModelTests: XCTestCase {

    private var cancellable: AnyCancellable?
    
    private let mockAPIManager = MockAPIManager()
    private var locationViewModel: LocationViewModel?
    private var emptyDatabaseProvider = EmptyMockDatabaseManager()
    
    
    override func setUpWithError() throws {
        locationViewModel = LocationViewModel(remoteLocationProvider: mockAPIManager, databaseProvider: emptyDatabaseProvider)
    }
    
    func testItemsFetchFromRemote() {
        sleep(2)
        cancellable = locationViewModel?.mapItems
            .publisher
            .collect()
            .sink { mapItems in
                XCTAssertEqual(mapItems.count, 5)
            }
    }
    
    func testAddMapItem() {
        let figureEightPools = MapItem(name: "Figure Eight Pools",
                                       notes: "",
                                       latitude: -34.194672370004255,
                                       longitude: 151.03864406939627)
        
        locationViewModel?.addMapItem(mapItem: figureEightPools)
        XCTAssertEqual(locationViewModel?.mapItems.count, 6)
    }
}
