//
//  ShowCatalogueWireframe.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 20/03/24.
//

import Foundation
import UIKit

class ShowCatalogueWireframe: WireFrameProtocol {
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
    
    init(navigationController:UINavigationController? = nil,controller:UIViewController? = nil) {
        let presenter = ShowCataloguePresenter()
        let interactor = ShowCatalogueInteractor()
        let view = ShowCatalogueViewController(nibName: "ShowCatalogueViewController", bundle: Bundle.main)
        let wireframe = ShowCatalogueWireframe()
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        
        wireframe.presenter = presenter
        interactor.presenter = presenter
        view.presenter = presenter
        
        guard let navigationController = navigationController else{
            guard let controller = controller else{
                return
            }
            wireframe.presentView(sourceController: controller, destinationController: view, modalPresentationStyle: .fullScreen, animated: true)
            return
        }
        wireframe.pushView(navigationController: navigationController, view: view)

    }
    
    static func getController() -> UIViewController {
        let presenter = ShowCataloguePresenter()
        let interactor = ShowCatalogueInteractor()
        let view = ShowCatalogueViewController(nibName: "ShowCatalogueViewController", bundle: Bundle.main)
        let wireframe = ShowCatalogueWireframe()
            
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        
        wireframe.presenter = presenter
        interactor.presenter = presenter
        view.presenter = presenter
            
        return view
    }

    
    func goToShowDetails(navigationController:UINavigationController?, show:ShowModel?) {
        _ = ShowDetailsWireframe(navigationController: navigationController, show: show)
    }
    
    deinit {
        debugPrint("<<<\(self)>>>")
    }
}
