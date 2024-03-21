//
//  ShowCatalogueInteractor.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 20/03/24.
//

import Foundation

class ShowCatalogueInteractor: InteractorProtocol {
    weak var presenter: PresenterProtocol?
    
    func observerError(_ error: String) {
        (self.presenter as? ShowCataloguePresenter)?.observerError(NSLocalizedString(error, comment: error))
    }
    
    func getShows(controller: TVMazeViewController?) {
        TVMazeDataStore(controller).getShows(correctAnswer: self.correctShowsAnswer(_:), errorAnswer: self.observerError(_:))
    }
    
    func correctShowsAnswer(_ data:Data) {
        var shows:[ShowModel] = []
        do{
            let decoder = JSONDecoder()
            shows = try decoder.decode([ShowModel].self, from: data)
            (self.presenter as? ShowCataloguePresenter)?.setShows(shows: shows)
        }catch let error {
            self.observerError("Error decoder: \(error.localizedDescription)")
        }
    }
    
    deinit {
        debugPrint("<<<\(self)>>>")
    }
}
