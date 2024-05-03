//
//  FavoriteModelLogicTests.swift
//  TVMaze_App_ExampleTests
//
//  Created by Adrian Iraizos Mendoza on 3/5/24.
//

import XCTest

@testable import TVMaze_App_Example
final class FavoriteModelLogicTests: XCTestCase {
    var container: DataBaseMock!
    var sut: FavoriteModelLogic!
    
    override func setUpWithError() throws {
        container = DataBaseMock()
        sut = FavoriteModelLogic(container: container)
    }

    override func tearDownWithError() throws {
        container = nil
        sut = nil
    }

    func testInitWhitFavoritesLoaded_ShouldBe1() {
        let favoritesCount = sut.favoritesCount
        
        XCTAssertEqual(favoritesCount, 1)
    }
    
    func testloadFavorites_ShouldBe() {
        let initialCount = sut.favoritesCount
        sut.loadFavorites()
        let finalCount = sut.favoritesCount
        
        XCTAssertEqual(initialCount, finalCount)
    }
    
    func testIsFavorite_ShouldBeFalse() throws {
        let isFavorite = sut.isFavorite(showId: Int.max)
        
        XCTAssertFalse(isFavorite)
    }
    
    func testIsFavorite_ShouldBeTrue() throws {
        let isFavorite = sut.isFavorite(showId: 1)
        
        XCTAssertTrue(isFavorite)
    }
    
    func testSaveFavorite_ShouldBe2() throws {
        let show = try XCTUnwrap(favoriteTest)
        
        sut.saveFavorite(show: show)
        
        let count = sut.favoritesCount
        
        XCTAssertEqual(count, 2)
    }
    
    func testDeleteFavorite_ShouldBe0() throws {
        let id = 1
        let initialCount = sut.favoritesCount
        
        sut.deleteFavorite(showId: id)
        
        let finalCount = sut.favoritesCount
        
        XCTAssertGreaterThan(initialCount, finalCount)
    }
    
        
    var favoriteTest:ShowModel? {
        let url = Bundle(for: FavoriteModelLogicTests.self).url(forResource: "FavoriteTest", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return try? JSONDecoder().decode(ShowModel.self, from: data)
    }
    
    
}
