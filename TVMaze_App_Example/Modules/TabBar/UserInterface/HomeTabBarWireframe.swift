//
//  HomeTabBarWireframe.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 21/03/24.
//

import Foundation
import UIKit

class HomeTabBarWireframe: WireFrameProtocol {
    weak var presenter: PresenterProtocol?
    
    func pushView(navigationController: UINavigationController, view: UIViewController) {
        navigationController.pushViewController(view, animated: true)
    }
    
    func presentView(sourceController:UIViewController,destinationController:UIViewController, modalPresentationStyle:UIModalPresentationStyle, animated:Bool) {
        let navigator = UINavigationController(rootViewController: destinationController)
        navigator.modalPresentationStyle = modalPresentationStyle
        destinationController.modalPresentationStyle = modalPresentationStyle
        sourceController.present(navigator, animated: animated)
    }
    
    init(){}
    
    init(navigationController: UINavigationController){
        let presenter = HomeTabBarPresenter()
        let interactor = HomeTabBarInteractor()
        let view = HomeTabBarViewController(nibName: "HomeTabBarViewController", bundle: Bundle.main)
        let wireframe = HomeTabBarWireframe()
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        
        wireframe.presenter = presenter
        interactor.presenter = presenter
        view.presenter = presenter
        
//        wireframe.pushView(navigationController: navigationController, view: view)
        let navigation = UINavigationController(rootViewController: view)
        
        if #available(iOS 13.0, *){
            if let scene = UIApplication.shared.connectedScenes.first{
                guard let windowScene = (scene as? UIWindowScene) else { return }
                debugPrint("<<<<<< windowScene: \(windowScene)")
                let window: UIWindow = UIWindow(frame: windowScene.coordinateSpace.bounds)
                window.windowScene = windowScene //Make sure to do this
                window.rootViewController = navigation
                window.makeKeyAndVisible()
                view.appDelegate.window = window
            }
        }else{
            view.appDelegate.window?.rootViewController = navigation
            view.appDelegate.window?.makeKeyAndVisible()
        }
        
    }
    
    deinit {
        debugPrint("<<<\(self)>>>")
    }
}

