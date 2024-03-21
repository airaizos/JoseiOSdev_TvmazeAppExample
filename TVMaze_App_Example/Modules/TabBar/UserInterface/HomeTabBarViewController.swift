//
//  HomeTabBarViewController.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 21/03/24.
//

import UIKit

class HomeTabBarViewController: UITabBarController, ViewProtocol {
    let appDelegate=UIApplication.shared.delegate as! AppDelegate
    var presenter: PresenterProtocol?
    
    var loaderActicity: UIActivityIndicatorView!
    

    @IBOutlet weak var btnCatalogueTabBar: UITabBarItem!
    @IBOutlet weak var btnFavoritesTabBar: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initController()
    }


    func initController(){
        //Setting TabBar
//        let tabbar = UITabBarController()//for new tabbarcontroller
        //init tabBArItems
        let catalogue = UITabBarItem(title: "CatalogueModuleTitle".localizable(), image: UIImage(named: "catalogue"), selectedImage: nil)
        let favorites = UITabBarItem(title: "FavoritesModuleTitle" .localizable(), image: UIImage(named: "favorites"), selectedImage: nil)
        catalogue.tag=0
        favorites.tag=1
        
        let items = [catalogue,favorites]
        self.btnCatalogueTabBar = catalogue
        self.btnFavoritesTabBar = favorites
        //initViewControllers
        let c0 = ShowCatalogueWireframe.getController()
        let c1 = ShowFavoritesWireframe.getController()
        let controllers:[UIViewController]=[c0,c1]
        
        //Setting ViewControllers on TabBar Items
        c0.tabBarItem = catalogue
        c1.tabBarItem = favorites
        
        self.tabBar.tintColor = .blue
        if #available(iOS 13.0, *) {
            self.tabBar.backgroundColor = .label
        } else {
            self.tabBar.backgroundColor = .white
        }
        
        self.viewControllers=controllers
        //Setting Title
        self.navigationItem.title = ""
        //TO SET TITLE IN CONTROLLERS : self.tabBarController?.navigationItem.title = ""
        
        self.selectedIndex=2
        let number = self.toolbarItems?.count
        debugPrint("<<<< number of items: \(number)")
        
    }
    
    deinit {
        debugPrint("<<<\(self)>>>")
    }
}
