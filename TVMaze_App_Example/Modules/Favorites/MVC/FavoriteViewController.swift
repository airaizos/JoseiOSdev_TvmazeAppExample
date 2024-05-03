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
            self.tableView.reloadData()
            
            dataSource.apply(modelLogic.snapshot)
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
    
    

    deinit {
        NotificationCenter.default.removeObserver(self, name: .favorites, object: nil)
    }
}

final class FavoritesDiffableTableViewDataSource: UICollectionViewDiffableDataSource<Int,FavoriteModel> {
    
}
