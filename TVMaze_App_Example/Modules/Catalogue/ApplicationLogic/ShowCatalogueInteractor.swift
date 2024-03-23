//
//  ShowCatalogueInteractor.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 20/03/24.
//

import Foundation
import CoreData
import UIKit

class ShowCatalogueInteractor: InteractorProtocol {
    weak var presenter: PresenterProtocol?
    
    func observerError(_ error: String) {
        (self.presenter as? ShowCataloguePresenter)?.observerError(NSLocalizedString(error, comment: error))
    }
    
    func getShows(controller: TVMazeViewController?) {
        TVMazeDataStore(controller).getShows(correctAnswer: self.correctShowsAnswer(_:), errorAnswer: self.errorGetShows(_:))
    }
    
    func errorGetShows(_ error:String) {
        let cancelAction = UIAlertAction(title: "Cancel".localizable(), style: .default)
        let retryAction = UIAlertAction(title: "RetryAction".localizable(), style: .default, handler: {_ in
            self.getShows(controller: (self.presenter?.view as? TVMazeViewController))
        })
        (self.presenter as? ShowCataloguePresenter)?.showMessage("GeneralServicesError".localizable(), actions: [cancelAction, retryAction], completion: nil)
    }
    
    func correctShowsAnswer(_ data:Data) {
        var shows:[ShowModel] = []
        do{
            let decoder = JSONDecoder()
            shows = try decoder.decode([ShowModel].self, from: data)
            (self.presenter as? ShowCataloguePresenter)?.setShows(shows: shows)
        }catch let error {
            self.errorGetShows("Error decoder: \(error.localizedDescription)")
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
    
    private func getFavoriteShow(coreDataController:CoreDataController ,showId:Int64) -> [FavoriteShow] {
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
    
    func saveFavorite(favoriteModel:FavoriteShowModel){
        let coreDataController = CoreDataController()
        let favorite = NSEntityDescription.insertNewObject(forEntityName: Constants.ENTITY, into: coreDataController.getContext()) as! FavoriteShow
        favorite.id = Int64(favoriteModel.id ?? 0)
        favorite.name = favoriteModel.name
        favorite.imageMedium = favoriteModel.imageMedium
        favorite.imageOriginal = favoriteModel.imageOriginal
        favorite.imdbURL = favoriteModel.imdbURL
        favorite.resume = favoriteModel.resume
        coreDataController.saveContext()
        (self.presenter as? ShowCataloguePresenter)?.correctSaveFavorite(favoriteModel: favoriteModel)
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
        }
        (self.presenter as? ShowCataloguePresenter)?.correctDeleteFavorite(favorite: favorite)
    }
    
    func errorDeleteCoreDataItem(favorite:FavoriteShowModel) {
        let cancelAction = UIAlertAction(title: "Cancel".localizable(), style: .default)
        let retryAction = UIAlertAction(title: "RetryAction".localizable(), style: .default, handler: {_ in 
            self.deleteFavorite(favorite: favorite)
        })
        (self.presenter as? ShowCataloguePresenter)?.showMessage("deleteCoreDataError".localizable(), actions: [cancelAction,retryAction], completion: nil)
    }
    
    deinit {
        debugPrint("<<<\(self)>>>")
    }
}
