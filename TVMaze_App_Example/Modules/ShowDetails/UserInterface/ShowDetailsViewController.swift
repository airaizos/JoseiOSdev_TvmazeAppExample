//
//  ShowDetailsViewController.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 20/03/24.
//

import UIKit

class ShowDetailsViewController: TVMazeViewController {
    @IBOutlet weak var btnOpenLink: UIButton!
    @IBOutlet weak var imgOriginal: UIImageView!
    @IBOutlet weak var lblSummary: UILabel!
    var show:ShowModel?{
        didSet{
            guard let id = self.show?.id else {
                self.isFavorite = false
                return
            }
            self.isFavorite = (self.presenter as? ShowDetailsPresenter)?.isFavoriteShow(showId: Int64(id)) ?? false
        }
    }
    var isFavorite:Bool = false {
        didSet{
            self.navigationItem.rightBarButtonItems?.first?.title = self.isFavorite ? "Delete".localizable() : "Favorite".localizable()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationBar.tintColor = .white
        }
    }
    
    private func initController() {
        (self.presenter as? ShowDetailsPresenter)?.getShow()
        self.setControllerText()
        self.setFavorite_DeleteButton()
    }
    
    private func setControllerText(){
        self.navigationItem.title = show?.name
        self.btnOpenLink.setTitle("openShow".localizable(), for: .normal)
    }
    
    func setShow(show:ShowModel?) {
        
        self.show = show
        self.lblSummary.text = show?.summary
        self.imgOriginal.imageFromUrl(urlString: self.show?.image?.original ?? "", force: false, placeholder: nil)
        guard let url = self.show?.url else {
            self.btnOpenLink.isHidden = true
            return
        }
        self.btnOpenLink.isHidden = url < "        "
    }
    
    private func setFavorite_DeleteButton() {
        let title:String = self.isFavorite ? "Delete".localizable() : "Favorite".localizable()
        let rightNavigationButton = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(delete_save))
        self.navigationItem.rightBarButtonItems = [rightNavigationButton]
    }
    
    @objc private func delete_save() {
        self.isFavorite ? self.deleteFavorite() : self.saveFavorite()
    }

    @IBAction func userTouchOpenLink(_ sender: Any) {
        guard let url = self.show?.url else {
            self.btnOpenLink.isHidden = true
            return
        }
        if url < "        " {
            self.btnOpenLink.isHidden = true
            return
        }
        (self.presenter as? ShowDetailsPresenter)?.openSafariUrl(url: url)
    }
    
    private func deleteFavorite() {
        guard let show = self.show else {
            self.errorDeleteCoreDataItem()
            return
        }
        guard let id = show.id else {
            self.errorDeleteCoreDataItem()
            return
        }
        let cancelAction = UIAlertAction(title: "Cancel".localizable(), style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete".localizable(), style: .destructive) { alertAction in
            let favorite = FavoriteShowModel(id: id, show: show)
            (self.presenter as? ShowDetailsPresenter)?.deleteFavorite(favorite: favorite)
            NotificationCenter.default.post(name: .detailFavorite, object: favorite)
        }
        self.showMessage(title:"TVMaze_App_Example","DeleteAlertMessage".localizable(), actions: [cancelAction, deleteAction], completion: nil)
        
    }
    
    private func errorDeleteCoreDataItem() {
        let cancelAction = UIAlertAction(title: "Cancel".localizable(), style: .default)
        let retryAction = UIAlertAction(title: "RetryAction".localizable(), style: .default, handler: {_ in
            self.deleteFavorite()
        })
        (self.presenter as? ShowDetailsPresenter)?.showMessage("deleteCoreDataError".localizable(), actions: [cancelAction,retryAction], completion: nil)
    }
    
    private func saveFavorite() {
        guard let show = self.show else {
            self.errorSaveCoreDataItem()
            return
        }
        guard let id = show.id else {
            self.errorSaveCoreDataItem()
            return
        }
        let favoriteModel = FavoriteShowModel(id: id, show: show)
        (self.presenter as? ShowDetailsPresenter)?.saveFavorite(favoriteModel: favoriteModel)
    }
    
    private func errorSaveCoreDataItem() {
        let cancelAction = UIAlertAction(title: "Cancel".localizable(), style: .default)
        let retryAction = UIAlertAction(title: "RetryAction".localizable(), style: .default, handler: {_ in
            self.saveFavorite()
        })
        (self.presenter as? ShowDetailsPresenter)?.showMessage("saveCoreDataError".localizable(), actions: [cancelAction,retryAction], completion: nil)
    }
    
    func correctSaveFavorite(favoriteModel:FavoriteShowModel) {
        self.isFavorite = true
    }
    
    func correctDeleteFavorite(favorite:FavoriteShowModel) {
        self.isFavorite = false
    }
    
    deinit {
        debugPrint("<<<\(self)>>>")
    }

}
