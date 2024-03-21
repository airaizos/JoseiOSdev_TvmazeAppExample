//
//  ShowDetailsInteractor.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 20/03/24.
//

import Foundation

class ShowDetailsInteractor: InteractorProtocol {
    weak var presenter: PresenterProtocol?
    var show:ShowModel?
    
    func observerError(_ error: String) {
        (self.presenter as? ShowDetailsPresenter)?.observerError(NSLocalizedString(error, comment: error))
    }
    
    func getShow() {
        (self.presenter as? ShowDetailsPresenter)?.setShow(show: self.show)
    }
    
    deinit {
        debugPrint("<<<\(self)>>>")
    }
}
