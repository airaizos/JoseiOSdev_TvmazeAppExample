//
//  FavoriteModelLogic.swift
//  TVMaze_App_Example
//
//  Created by Adrian Iraizos Mendoza on 2/5/24.
//

import UIKit
import CoreData

final class FavoriteModelLogic {
    
    static let shared = FavoriteModelLogic()
    
    private let network: TVMazeDataStore
    
    private var error: String? {
        didSet {
            NotificationCenter.default.post(name: .errorFavorite, object: error)
        }
    }
    
    private var errorMessageActions: (String,[UIAlertAction])? {
        didSet {
            NotificationCenter.default.post(name: .errorFavorite, object: errorMessageActions)
        }
    }
    
    var favorites = [FavoriteModel]() {
        didSet {
            NotificationCenter.default.post(name: .favorites, object: nil)
        }
    }
    
    var favoritesCount: Int {
        favorites.count
    }
    let container: DataBaseContainer
    
    init(container: DataBaseContainer = CoreDataController.shared, network: TVMazeDataStore = .init()) {
        self.container = container
        self.network = network
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
        } catch  {
            self.errorMessageActions = errorRetryAction()
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
    
    func getFavorite(for indexPath: IndexPath) async throws -> ShowModel {
        let favoriteId = favorites[indexPath.row].id
        return try await network.getShowAsync(id: favoriteId)
    }
    
    func errorRetryAction() -> (String,[UIAlertAction]) {
        let cancelAction = UIAlertAction(title: "Cancel".localizable(), style: .default)
        let retryAction = UIAlertAction(title: "RetryAction".localizable(), style: .default, handler: { _ in
            self.loadFavorites()
        })
        return ("loadCoreDataError".localizable(),[cancelAction,retryAction])
    }
}


func showError() throws {
    enum CustomError:Error {
        case throwError
    }
   throw CustomError.throwError
}
