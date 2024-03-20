//
//  Protocols.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 20/03/24.
//

import Foundation
import UIKit

protocol ViewProtocol: AnyObject {
    var presenter: PresenterProtocol? {get set}
    var loaderActicity:UIActivityIndicatorView! {get set}
}

protocol PresenterProtocol: AnyObject {
    var view: ViewProtocol? {get set}
    var wireframe: WireFrameProtocol? {get set}
    var interactor: InteractorProtocol? {get set}
    func observerError(_ error:String)
    func showMessage(_ message:String, actions:[UIAlertAction], completion:(() -> Void)?)
    
}

protocol InteractorProtocol: AnyObject {
    var presenter: PresenterProtocol? {get set}
    func observerError(_ error:String)
}

protocol WireFrameProtocol: AnyObject {
    var presenter: PresenterProtocol? {get set}
    func pushView(navigationController: UINavigationController, view:UIViewController)
    func presentView(sourceController:UIViewController,destinationController:UIViewController, modalPresentationStyle:UIModalPresentationStyle, animated:Bool)
}

