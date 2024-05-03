//
//  DataBaseMock.swift
//  TVMaze_App_ExampleTests
//
//  Created by Adrian Iraizos Mendoza on 3/5/24.
//

import Foundation
import CoreData

@testable import TVMaze_App_Example
final class DataBaseMock: DataBaseContainer {
    var favoriteShows = [ShowModel]()
    
    init() {
        let url = Bundle(for: DataBaseMock.self).url(forResource: "ShowTests", withExtension: "json")!
        do {
            let data = try Data(contentsOf: url)
            let shows = try JSONDecoder().decode([ShowModel].self, from: data)
            guard let first = shows.first else { return }
            self.favoriteShows = [first]
        } catch {
            return
        }
    }
    
    func fetchFavorites() throws -> [FavoriteModel] {
        favoriteShows.compactMap { FavoriteModel(show: $0) }
    }
    
    func isFavorite(showId: Int) throws -> Bool {
        favoriteShows.contains(where: { $0.id == showId } )
    }
    
    func saveFavorite(show: ShowModel) -> Bool {
        favoriteShows.append(show)
        return true
    }
    
    func deleteShow(id: Int) throws {
        favoriteShows.removeAll(where: { $0.id == id } )
    }
    
    func getFavoritesShows() throws -> [FavoriteShowModel] {
        favoriteShows.compactMap { show in
            if let id = show.id {
                return FavoriteShowModel(id: id, show: show)
            }
            return nil
        }
    }
}
