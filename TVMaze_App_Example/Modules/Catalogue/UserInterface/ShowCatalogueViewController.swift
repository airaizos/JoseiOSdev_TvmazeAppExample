//
//  ShowCatalogueViewController.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 20/03/24.
//

import UIKit

class ShowCatalogueViewController: TVMazeViewController {
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
        if self.shows.count == 0 {
            self.getData()
        }
    }

    private func initController(){
        self.setControllerText()
        self.initTableView()
    }
    
    private func setControllerText(){
        self.lblTitle.text = "CatalogueModuleTitle".localizable()
        //self.navigationItem.title = "CatalogueModuleTitle".localizable()
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
        (self.presenter as? ShowCataloguePresenter)?.deleteFavorite(favorite: favorite)
    }
    
    private func errorDeleteCoreDataItem(indexPath:IndexPath) {
        let cancelAction = UIAlertAction(title: "Cancel".localizable(), style: .default)
        let retryAction = UIAlertAction(title: "RetryAction".localizable(), style: .default, handler: {_ in
            self.deleteFavorite(indexPath: indexPath)
        })
        (self.presenter as? ShowCataloguePresenter)?.showMessage("deleteCoreDataError".localizable(), actions: [cancelAction,retryAction], completion: nil)
    }
    
    private func saveFavorite(indexPath: IndexPath) {
        guard let show = self.shows[indexPath.row] else {
            self.errorSaveCoreDataItem(indexPath: indexPath)
            return
        }
        guard let id = show.id else {
            self.errorSaveCoreDataItem(indexPath: indexPath)
            return
        }
        let favoriteModel = FavoriteShowModel(id: id, show: show)
        (self.presenter as? ShowCataloguePresenter)?.saveFavorite(favoriteModel: favoriteModel)
    }
    
    private func errorSaveCoreDataItem(indexPath:IndexPath) {
        let cancelAction = UIAlertAction(title: "Cancel".localizable(), style: .default)
        let retryAction = UIAlertAction(title: "RetryAction".localizable(), style: .default, handler: {_ in
            self.saveFavorite(indexPath: indexPath)
        })
        (self.presenter as? ShowCataloguePresenter)?.showMessage("saveCoreDataError".localizable(), actions: [cancelAction,retryAction], completion: nil)
    }
    
    func correctSaveFavorite(favoriteModel:FavoriteShowModel) {
//        self.tableView.reloadData()
    }
    
    func correctDeleteFavorite(favorite:FavoriteShowModel) {
//        self.tableView.reloadData()
    }
    
    deinit {
        debugPrint("<<<\(self)>>>")
    }

}

extension ShowCatalogueViewController:UITableViewDelegate,UITableViewDataSource{
    
    func setShows(shows:[ShowModel]?) {
        self.shows = shows ?? []
        self.removeLoader()
    }
    
    func getData() {
        (self.presenter as? ShowCataloguePresenter)?.getShows(controller: self)
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
        (self.presenter as? ShowCataloguePresenter)?.goToShowDetails(navigationController: self.navigationController, show: self.shows[indexPath.row])
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
        let favoriteAction = UITableViewRowAction(style: .normal, title: "Favorite".localizable(), handler: { (action, indexPath) in
            //favoriteactions
            self.saveFavorite(indexPath: indexPath)
        })
        favoriteAction.backgroundColor = UIColor.green
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete".localizable()) { (action, indexPath) in
            //deleteaction
            let cancelAction = UIAlertAction(title: "Cancel".localizable(), style: .cancel)
            let deleteAction = UIAlertAction(title: "Delete".localizable(), style: .destructive) { alertAction in
                self.deleteFavorite(indexPath: indexPath)
            }
            self.showMessage(title:"TVMaze_App_Example","DeleteAlertMessage".localizable(), actions: [cancelAction, deleteAction], completion: nil)
        }
        
        let show = self.shows[indexPath.row]
        
        guard let id = show?.id else {
            return [favoriteAction]
        }
        
        let isFavorite:Bool = (self.presenter as? ShowCataloguePresenter)?.isFavoriteShow(showId: Int64(id)) ?? false

        return isFavorite ? [deleteAction] : [favoriteAction]
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // Implement delete functionality.
        tableView.reloadData()
    }
    
}
