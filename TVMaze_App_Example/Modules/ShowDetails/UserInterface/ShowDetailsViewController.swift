//
//  ShowDetailsViewController.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 20/03/24.
//

import UIKit

class ShowDetailsViewController: TVMazeViewController {
    @IBOutlet weak var imgOriginal: UIImageView!
    @IBOutlet weak var lblSummary: UILabel!
    var show:ShowModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
    }
    
    private func initController() {
        (self.presenter as? ShowDetailsPresenter)?.getShow()
        self.setControllerText()
    }
    
    private func setControllerText(){
        self.navigationItem.title = show?.name
    }
    
    func setShow(show:ShowModel?) {
        self.show = show
        self.lblSummary.text = show?.summary
    }


    deinit {
        debugPrint("<<<\(self)>>>")
    }

}
