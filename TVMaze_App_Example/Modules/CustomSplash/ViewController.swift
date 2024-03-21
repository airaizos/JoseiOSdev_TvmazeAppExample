//
//  ViewController.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 19/03/24.
//

import UIKit

class ViewController: TVMazeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
//            _ = ShowCatalogueWireframe(navigationController: self.navigationController)
//            _ = ShowFavoritesWireframe(navigationController: self.navigationController)
        })
    }
    
    deinit {
        debugPrint("<<<\(self)>>>")
    }

}

