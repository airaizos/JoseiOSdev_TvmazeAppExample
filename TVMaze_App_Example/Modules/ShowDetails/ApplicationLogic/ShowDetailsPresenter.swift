//
//  ShowDetailsPresenter.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 20/03/24.
//

import Foundation
import UIKit

class ShowDetailsPresenter: PresenterProtocol {
    weak var view: ViewProtocol?
    
    var wireframe: WireFrameProtocol?
    
    var interactor: InteractorProtocol?
    
    func observerError(_ error: String) {
        (self.view as? TVMazeViewController)?.observerError(NSLocalizedString(error, comment: error))
    }
    
    func showMessage(_ message: String, actions: [UIAlertAction], completion: (() -> Void)?) {
        (self.view as? TVMazeViewController)?.showMessage(message, actions: actions, completion: completion)
    }
    
    func getShow() {
        (self.interactor as? ShowDetailsInteractor)?.getShow()
    }
    
    func setShow(show:ShowModel?) {
        (self.view as? ShowDetailsViewController)?.setShow(show: show)
    }
    
    func openSafariUrl(url:String){
        Utils.openURLWithSafari(url: url, errorAnswer: self.errorOpenUrl(_:url:))
    }
    
    func errorOpenUrl(_ error:String, url:String) {
        let cancelAction = UIAlertAction(title: "Cancel".localizable(), style: .default)
        let retryAction = UIAlertAction(title: "RetryAction".localizable(), style: .default, handler: {_ in 
            self.openSafariUrl(url: url)
        })
        self.showMessage("GeneralServicesError".localizable(), actions: [cancelAction, retryAction], completion: nil)
    }
    
    func isFavoriteShow(showId:Int64) -> Bool {
        return (self.interactor as? ShowDetailsInteractor)?.isFavoriteShow(showId: showId) ?? false
    }
    
    func saveFavorite(favoriteModel:FavoriteShowModel){
        (self.interactor as? ShowDetailsInteractor)?.saveFavorite(favoriteModel: favoriteModel)
    }
    
    func correctSaveFavorite(favoriteModel:FavoriteShowModel) {
        (self.view as? ShowDetailsViewController)?.correctSaveFavorite(favoriteModel:favoriteModel)
    }
    
    func deleteFavorite(favorite:FavoriteShowModel) {
        (self.interactor as? ShowDetailsInteractor)?.deleteFavorite(favorite: favorite)
    }
    
    func correctDeleteFavorite(favorite:FavoriteShowModel) {
        (self.view as? ShowDetailsViewController)?.correctDeleteFavorite(favorite:favorite)
    }
    
    deinit {
        debugPrint("<<<\(self)>>>")
    }
}

