//
//  FavoriteModelLogic.swift
//  TVMaze_App_Example
//
//  Created by Adrian Iraizos Mendoza on 2/5/24.
//

import UIKit
import CoreData

final class FavoriteModelLogic {
   // typealias FavoriteShowRequest = NSFetchRequest<FavoriteShow>
    
    static let shared = FavoriteModelLogic()
    
    var favorites = [FavoriteModel]() {
        didSet {
            NotificationCenter.default.post(name: .favorites, object: nil)
        }
    }
    
    var favoritesCount: Int {
        favorites.count
    }
    let container: DataBaseContainer
    
    init(container: DataBaseContainer = CoreDataController.shared) {
        self.container = container
        loadFavorites()
    }
    
    var snapshot: NSDiffableDataSourceSnapshot<Int,FavoriteModel> {
    var snapshot = NSDiffableDataSourceSnapshot<Int,FavoriteModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(favorites, toSection: 0)
        return snapshot
    }
    
    func loadFavorites() {
        do {
            self.favorites = try container.fetchFavorites()
        } catch {
            //TODO: Error
        }
    }
    
    func isFavorite(showId: Int) -> Bool {
        do {
            return try container.isFavorite(showId: showId)
        } catch {
            return false
        }
    }
    
    @discardableResult
    func saveFavorite(show: ShowModel) -> Bool {
        let isSaved = container.saveFavorite(show: show)
        loadFavorites()
        return isSaved
    }
    
    @discardableResult
    func deleteFavorite(showId: Int) -> Bool {
        do {
            try container.deleteShow(id: showId)
            loadFavorites()
            return true
        } catch {
            return false
        }
    }
}
