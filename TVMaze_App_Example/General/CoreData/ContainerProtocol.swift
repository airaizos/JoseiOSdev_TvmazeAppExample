//
//  ContainerProtocol.swift
//  TVMaze_App_Example
//
//  Created by Adrian Iraizos Mendoza on 3/5/24.
//

import Foundation
import CoreData

protocol DataBaseContainer {
    func fetchFavorites() throws -> [FavoriteModel]
    func isFavorite(showId: Int) throws -> Bool
    func saveFavorite(show: ShowModel) -> Bool
    func deleteShow(id: Int) throws
    func getFavoritesShows() throws -> [FavoriteShowModel]
}
