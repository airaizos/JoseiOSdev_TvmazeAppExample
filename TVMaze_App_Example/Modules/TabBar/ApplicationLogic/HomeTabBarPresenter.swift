//
//  HomeTabBarPresenter.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 21/03/24.
//

import Foundation
import UIKit

class HomeTabBarPresenter:PresenterProtocol{
    weak var view: ViewProtocol?
    
    var wireframe: WireFrameProtocol?
    
    var interactor: InteractorProtocol?
    
    func observerError(_ error: String) {
        (self.view as? TVMazeViewController)?.removeLoader()
        (self.view as? TVMazeViewController)?.observerError(error)
    }
    
    func showMessage(_ message: String, actions: [UIAlertAction], completion: (() -> Void)?) {
        (self.view as? TVMazeViewController)?.showMessage(message, actions: actions, completion: completion)
    }
    
    deinit {
        debugPrint("<<<\(self)>>>")
    }
}
