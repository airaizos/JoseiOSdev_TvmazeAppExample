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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DispatchQueue.main.async {
            self.removeLoader()
        }
    }

    private func initController(){
        self.setControllerText()
        self.initTableView()
    }
    
    private func setControllerText(){
        self.lblTitle.text = "FavoritesModuleTitle".localizable()
    }

    private func deleteFavorite(indexPath: IndexPath) {
        guard let show = self.shows[indexPath.row] else {
            self.errorDeleteCoreDataItem(indexPath: indexPath)
            return
        }
        guard let id = show.id else {
            self.errorDeleteCoreDataItem(indexPath: indexPath)
            return
        }
        let favorite = FavoriteShowModel(id: id, show: show)
        (self.presenter as? ShowFavoritesPresenter)?.deleteFavorite(favorite: favorite)
    }
    
    private func errorDeleteCoreDataItem(indexPath:IndexPath) {
        let cancelAction = UIAlertAction(title: "Cancel".localizable(), style: .default)
        let retryAction = UIAlertAction(title: "RetryAction".localizable(), style: .default, handler: {_ in
            self.deleteFavorite(indexPath: indexPath)
        })
        (self.presenter as? ShowFavoritesPresenter)?.showMessage("deleteCoreDataError".localizable(), actions: [cancelAction,retryAction], completion: nil)
    }
    
    func correctDeleteFavorite(favorite:FavoriteShowModel) {
        self.shows.removeAll { show in
            show?.id ?? 0 == favorite.id
        }
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
//        self.getData()
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
    
    //EditingStyles
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete".localizable()) { (action, indexPath) in
            //deleteaction
            let cancelAction = UIAlertAction(title: "Cancel".localizable(), style: .cancel)
            let deleteAction = UIAlertAction(title: "Delete".localizable(), style: .destructive) { alertAction in
                self.deleteFavorite(indexPath: indexPath)
            }
            self.showMessage(title:"TVMaze_App_Example","DeleteAlertMessage".localizable(), actions: [cancelAction, deleteAction], completion: nil)
        }

        return [deleteAction]
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // Implement delete functionality.
        tableView.reloadData()
    }
    
}
