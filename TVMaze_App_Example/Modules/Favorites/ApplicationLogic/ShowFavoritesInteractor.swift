//
//  ShowFavoritesInteractor.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 20/03/24.
//

import Foundation
import CoreData
import UIKit

class ShowFavoritesInteractor: InteractorProtocol {
    weak var presenter: PresenterProtocol?
    
    func observerError(_ error: String) {
        (self.presenter as? ShowFavoritesPresenter)?.observerError(NSLocalizedString(error, comment: error))
    }
    
    func getShows(controller: TVMazeViewController?) {
        TVMazeDataStore(controller).getShows(correctAnswer: self.correctShowsAnswer(_:), errorAnswer: self.errorGetShows(_:))
    }
    
    func correctShowsAnswer(_ data:Data) {
        var shows:[ShowModel] = []
        do{
            let decoder = JSONDecoder()
            shows = try decoder.decode([ShowModel].self, from: data)
            let favoriteShows = shows.filter { show in
                if let id = show.id {
                    self.isFavoriteShow(showId: Int64(id))
                }else {
                    false
                }
            }
            (self.presenter as? ShowFavoritesPresenter)?.setShows(shows: favoriteShows)
        }catch let error {
            self.errorGetShows("Error decoder: \(error.localizedDescription)")
        }
    }
    
    func errorGetShows(_ error:String) {
        let cancelAction = UIAlertAction(title: "Cancel".localizable(), style: .default)
        let retryAction = UIAlertAction(title: "RetryAction".localizable(), style: .default, handler: {_ in
            self.getShows(controller: (self.presenter?.view as? TVMazeViewController))
        })
        (self.presenter as? ShowFavoritesPresenter)?.showMessage("GeneralServicesError".localizable(), actions: [cancelAction, retryAction], completion: nil)
    }
    
    func getFavoritesShows() -> [FavoriteShowModel]{
        var favorites:[FavoriteShowModel]=[]
        let coreDataController = CoreDataController()
        let fetchRequest: NSFetchRequest<FavoriteShow> = FavoriteShow.fetchRequest()
        do {
            let searchResults = try coreDataController.getContext().fetch(fetchRequest)
            if searchResults.count > 0 {
                for favorite in searchResults {
                    favorites.append(FavoriteShowModel(show: favorite))
                }
                return favorites
            }else{
                return favorites
            }
        } catch {
            return favorites
        }
        
    }
    
    func isFavoriteShow(showId:Int64) -> Bool {
        let coreDataController = CoreDataController()
        let fetchRequest: NSFetchRequest<FavoriteShow> = FavoriteShow.fetchRequest()
        let predicate:NSPredicate = NSPredicate(format: "id == %lld", showId)
        fetchRequest.predicate = predicate
        do{
            let searchResults = try coreDataController.getContext().fetch(fetchRequest)
            if searchResults.count > 0 {
                return true
            }else {
                return false
            }
        }catch{
            return false
        }
    }
    
    private func getFavoriteShow(coreDataController:CoreDataController,showId:Int64) -> [FavoriteShow] {
        let fetchRequest: NSFetchRequest<FavoriteShow> = FavoriteShow.fetchRequest()
        let predicate:NSPredicate = NSPredicate(format: "id == %lld", showId)
        fetchRequest.predicate = predicate
        do{
            let searchResults = try coreDataController.getContext().fetch(fetchRequest)
            if searchResults.count > 0 {
                return searchResults
            }else {
                return []
            }
        }catch{
            return []
        }
    }
    
    func deleteFavorite(favorite:FavoriteShowModel) {
        guard let id = favorite.id else {
            self.errorDeleteCoreDataItem(favorite: favorite)
            return
        }
        let coreDataController = CoreDataController()
        let favorites = self.getFavoriteShow(coreDataController: coreDataController, showId: Int64(id))
        var deleteState = favorites.count > 0 ? true : false
        favorites.forEach { deleteFavorite in
            if !coreDataController.deleteItem(object: deleteFavorite) {
                deleteState = false
            }
        }
        if !deleteState {
            self.errorDeleteCoreDataItem(favorite: favorite)
            return
        }else{
            (self.presenter as? ShowFavoritesPresenter)?.correctDeleteFavorite(favorite: favorite)
        }
    }
    
    func errorDeleteCoreDataItem(favorite:FavoriteShowModel) {
        let cancelAction = UIAlertAction(title: "Cancel".localizable(), style: .default)
        let retryAction = UIAlertAction(title: "RetryAction".localizable(), style: .default, handler: {_ in
            self.deleteFavorite(favorite: favorite)
        })
        (self.presenter as? ShowFavoritesPresenter)?.showMessage("deleteCoreDataError".localizable(), actions: [cancelAction,retryAction], completion: nil)
    }
    
    deinit {
        debugPrint("<<<\(self)>>>")
    }
}
