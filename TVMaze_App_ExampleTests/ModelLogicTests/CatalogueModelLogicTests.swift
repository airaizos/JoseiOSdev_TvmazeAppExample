//
//  TVMaze_App_ExampleTests.swift
//  TVMaze_App_ExampleTests
//
//  Created by José Caballero on 19/03/24.
//

import XCTest
@testable import TVMaze_App_Example

final class CatalogueModelLogicTests: XCTestCase {
    var sut: CatalogueModelLogic!
    var network: TVMazeDataStore!
    
    override func setUpWithError() throws {
        network = TVMazeDataStore(urlProtocol: URLSessionMock.self)
        sut = CatalogueModelLogic(network: network)
    }

    override func tearDownWithError() throws {
        network = nil
        sut = nil
    }

    func testGetShows_ShouldBe3() async throws {
        let initialCount = sut.showsCount
        try await sut.getShows()
       
        let finalCount = sut.showsCount
        
        XCTAssertEqual(finalCount, 3)
        XCTAssertGreaterThan(finalCount,initialCount)
    }
    
    func testIsFavorite_ShouldBeTrue() async throws {
        
        try await sut.getShows()
        
        
    }
}
