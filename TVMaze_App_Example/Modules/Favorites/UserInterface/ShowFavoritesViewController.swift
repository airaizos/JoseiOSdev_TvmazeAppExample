//
//  ShowFavoritesViewController.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 20/03/24.
//

import UIKit

class ShowFavoritesViewController: TVMazeViewController {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var shows:[ShowModel?] = [] {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initController()
    }

    private func initController(){
        self.setControllerText()
        self.initTableView()
    }
    
    private func setControllerText(){
        self.lblTitle.text = "CatalogueModuleTitle".localizable()
        //self.navigationItem.title = "CatalogueModuleTitle".localizable()
    }
    
    deinit {
        debugPrint("<<<\(self)>>>")
    }

}

extension ShowFavoritesViewController:UITableViewDelegate,UITableViewDataSource{
    
    func setShows(shows:[ShowModel]?) {
        self.shows = shows ?? []
        self.removeLoader()
    }
    
    func getData() {
        (self.presenter as? ShowFavoritesPresenter)?.getShows(controller: self)
    }
    
    func initTableView(){
        self.registerTableViewCells()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.backgroundColor = .clear
        self.getData()
    }
    
    func registerTableViewCells() {
        self.tableView.register(UINib(nibName: "ShowCatalogueTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ShowCatalogueTableViewCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.shows.count
        default:
            return self.shows.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            let cell:ShowCatalogueTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "ShowCatalogueTableViewCell", for: indexPath) as! ShowCatalogueTableViewCell
            cell.fillCell(show: self.shows[indexPath.row], indexPath: indexPath, presenter: self.presenter)
            return cell
        default:
            let cell:ShowCatalogueTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "ShowCatalogueTableViewCell", for: indexPath) as! ShowCatalogueTableViewCell
            cell.fillCell(show: self.shows[indexPath.row], indexPath: indexPath, presenter: self.presenter)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        (self.presenter as? ShowFavoritesPresenter)?.goToShowDetails(navigationController: self.navigationController, show: self.shows[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100
        default:
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.5) {
            cell.alpha = 1
        }
    }
    
}
