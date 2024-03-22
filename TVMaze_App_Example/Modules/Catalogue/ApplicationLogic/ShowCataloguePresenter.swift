//
//  ShowCataloguePresenter.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 20/03/24.
//

import Foundation
import UIKit

class ShowCataloguePresenter: PresenterProtocol {
    weak var view: ViewProtocol?
    
    var wireframe: WireFrameProtocol?
    
    var interactor: InteractorProtocol?
    
    func observerError(_ error: String) {
        (self.view as? TVMazeViewController)?.observerError(NSLocalizedString(error, comment: error))
    }
    
    func showMessage(_ message: String, actions: [UIAlertAction], completion: (() -> Void)?) {
        (self.view as? TVMazeViewController)?.showMessage(message, actions: actions, completion: completion)
    }
    
    func getShows(controller: TVMazeViewController?) {
        (self.interactor as? ShowCatalogueInteractor)?.getShows(controller: controller)
    }
    
    func setShows(shows:[ShowModel]?) {
        (self.view as? ShowCatalogueViewController)?.setShows(shows: shows)
    }
    
    func isFavoriteShow(showId:Int64) -> Bool {
        return (self.interactor as? ShowCatalogueInteractor)?.isFavoriteShow(showId: showId) ?? false
    }
    
    func saveFavorite(favoriteModel:FavoriteShowModel){
        (self.interactor as? ShowCatalogueInteractor)?.saveFavorite(favoriteModel: favoriteModel)
    }
    
    func correctSaveFavorite(favoriteModel:FavoriteShowModel) {
        (self.view as? ShowCatalogueViewController)?.correctSaveFavorite(favoriteModel:favoriteModel)
    }
    
    func deleteFavorite(favorite:FavoriteShowModel) {
        (self.interactor as? ShowCatalogueInteractor)?.deleteFavorite(favorite: favorite)
    }
    
    func correctDeleteFavorite(favorite:FavoriteShowModel) {
        (self.view as? ShowCatalogueViewController)?.correctDeleteFavorite(favorite:favorite)
    }
    
    func goToShowDetails(navigationController: UINavigationController?, show:ShowModel?) {
        (self.wireframe as? ShowCatalogueWireframe)?.goToShowDetails(navigationController: navigationController, show: show)
    }
    
    deinit {
        debugPrint("<<<\(self)>>>")
    }
}
