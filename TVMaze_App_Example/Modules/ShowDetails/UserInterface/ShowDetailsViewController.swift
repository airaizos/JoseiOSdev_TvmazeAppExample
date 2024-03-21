//
//  ShowDetailsViewController.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 20/03/24.
//

import UIKit

class ShowDetailsViewController: TVMazeViewController {
    var show:ShowModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initController()
    }
    
    private func initController() {
        (self.presenter as? ShowDetailsPresenter)?.getShow()
        self.setControllerText()
    }
    
    private func setControllerText(){
        self.navigationItem.title = "DetailsModuleTitle".localizable()
    }
    
    func setShow(show:ShowModel?) {
        self.show = show
    }


    deinit {
        debugPrint("<<<\(self)>>>")
    }

}
