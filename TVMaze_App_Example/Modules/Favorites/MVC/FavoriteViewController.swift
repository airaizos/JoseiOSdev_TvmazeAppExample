//
//  FavoriteViewController.swift
//  TVMaze_App_Example
//
//  Created by Adrian Iraizos Mendoza on 2/5/24.
//

import UIKit

final class FavoriteViewController: UITableViewController {

    private let modelLogic = FavoriteModelLogic.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibCell = UINib(nibName: "FavoritesViewCell", bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: "favoriteCell")
        
        tableView.dataSource = dataSource
        
        dataSource.apply(modelLogic.snapshot)
        NotificationCenter.default.addObserver(forName: .favorites, object: nil, queue: .main) { [self] _ in
            dataSource.apply(modelLogic.snapshot)
            self.tableView.reloadData()
        }
        
        NotificationCenter.default.addObserver(forName: .detailFavorite, object: nil, queue: .main) { [self] notification in
            guard let show = notification.object as? FavoriteShowModel, let id = show.id else { return }
            
            self.modelLogic.loadFavorites()
        }
        
        NotificationCenter.default.addObserver(forName: .errorFavorite, object: nil, queue: .main) { [self] notification in
            
            if let errorActions = notification.object as? (String,[UIAlertAction]) {
                self.showError(errorActions.0,actions: errorActions.1)
            }
        }
    }
    
 
    lazy var dataSource: UITableViewDiffableDataSource<Int,FavoriteModel> = {
        UITableViewDiffableDataSource(tableView: tableView) { [self] tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoriteViewCell else { return UITableViewCell() }
            
            cell.imageLabel.imageFromUrl(urlString: item.imageOriginal, force: false, placeholder: nil)
            cell.titlelabel.text = item.name
            cell.ratingLabel.text = item.rating
            return cell
        }
    }()

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let show = dataSource.itemIdentifier(for: indexPath) else { return nil }
        
        guard modelLogic.isFavorite(showId: show.id) else { return nil }
        
        let deleteFavoriteAction = UIContextualAction(style: .destructive, title: "Quit") { [self] _,_,handler in
            modelLogic.deleteFavorite(showId: show.id)
            dataSource.apply(modelLogic.snapshot,animatingDifferences: true)
            handler(true)
        }
            deleteFavoriteAction.image = UIImage.buttonWithSymbolConfiguration(systemName: "star.slash", color: .systemRed)
            deleteFavoriteAction.backgroundColor = .systemRed.withAlphaComponent(0.5)
            
            return UISwipeActionsConfiguration(actions: [deleteFavoriteAction])
        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigationController else { return }
        Task {
           let show = try await modelLogic.getFavorite(for: indexPath)
            let _ = ShowDetailsWireframe(navigationController: navigationController, show: show)
        }
    }
    
    func showMessage(title: String? = nil, message: String, actions: [UIAlertAction], completion:(() -> Void)?) {
        DispatchQueue.main.async {
            Utils.showSimpleAlert(title: title ?? Constants.APP_TITLE, message: message, controller: self, actions: actions, completion: completion)
        }
    }
    
    func showError(_ error: String, actions: [UIAlertAction]) {
        DispatchQueue.main.async {
           
            
            if actions.isEmpty {
                let okAction = UIAlertAction(title: "ok", style: .default)
                Utils.showSimpleAlert(title: Constants.APP_TITLE, message: error, controller: self, actions: [okAction], completion: nil)
                
            } else {
                Utils.showSimpleAlert(title: Constants.APP_TITLE, message: error, controller: self, actions: actions, completion: nil)
            }
        }
    }
    

    deinit {
        NotificationCenter.default.removeObserver(self, name: .favorites, object: nil)
        NotificationCenter.default.removeObserver(self, name: .detailFavorite, object: nil)
        NotificationCenter.default.removeObserver(self, name: .errorFavorite, object: nil)
    }
}

final class FavoritesDiffableTableViewDataSource: UICollectionViewDiffableDataSource<Int,FavoriteModel> {
    
}
