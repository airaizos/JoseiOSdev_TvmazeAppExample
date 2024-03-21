//
//  HomeTabBarInteractor.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 21/03/24.
//

import Foundation

class HomeTabBarInteractor: InteractorProtocol {
    weak var presenter: PresenterProtocol?
    
    func observerError(_ error: String) {
        (self.presenter as? HomeTabBarPresenter)?.observerError(NSLocalizedString(error, comment: error))
    }
    
    deinit {
        debugPrint("<<<\(self)>>>")
    }
}

