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
    
    deinit {
        debugPrint("<<<\(self)>>>")
    }
}

