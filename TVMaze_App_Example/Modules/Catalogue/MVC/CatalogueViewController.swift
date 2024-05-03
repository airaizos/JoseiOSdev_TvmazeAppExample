//
//  CatalogueViewController.swift
//  TVMaze_App_Example
//
//  Created by Adrian Iraizos Mendoza on 1/5/24.
//

import UIKit

final class CatalogueViewController: UITableViewController {
    
    let modelLogic = CatalogueModelLogic.shared

    lazy var dataSource: UITableViewDiffableDataSource<Int,ShowModel> = {
        UITableViewDiffableDataSource(tableView: tableView) { [self] tableView, indexPath, show in
            if let cell = tableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath) as? CatalogueViewCell {
                
                cell.imageLabel.imageFromUrl(urlString: show.image?.original ?? "", force: false, placeholder: nil)
                cell.titleLabel.text = show.name
                cell.ratingLabel.text = show.rating?.average != nil
                ? "Rating \(show.rating?.average ?? 0)"
                : "No rating".localizable()
                cell.genresLabel.text = show.genres?.sorted(by: <).joined(separator: ", ")
            
            return cell
            }  else {
                return UITableViewCell()
            }
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibCell = UINib(nibName: "CatalogueViewCell", bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: "showCell")
        
        tableView.dataSource = dataSource
        dataSource.apply(modelLogic.snapshot,animatingDifferences: true)
        
        NotificationCenter.default.addObserver(forName: .shows, object: nil, queue: .main) { [weak self] _ in
            self?.tableView.reloadData()
            if let snapshot = self?.modelLogic.snapshot {
                self?.dataSource.apply(snapshot, animatingDifferences: true)
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        Task {
           try await modelLogic.getShows()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let show = dataSource.itemIdentifier(for: indexPath), let id = show.id else { return nil }
        let isFavorite = modelLogic.isFavorite(id: id)
        
        let favoriteAction = UIContextualAction(style: .normal, title: isFavorite ? "Quit" : "Favorite") { [self] _, _, handler in
            modelLogic.toggleFavorite(show: show)
            dataSource.apply(modelLogic.snapshot, animatingDifferences: true)
            handler(true)
        }
        favoriteAction.image = UIImage.buttonWithSymbolConfiguration(systemName: "star.circle", color: UIColor.systemRed)
        
        favoriteAction.backgroundColor = isFavorite ? .systemRed.withAlphaComponent(0.5): .systemYellow.withAlphaComponent(0.5)
        return UISwipeActionsConfiguration(actions: [favoriteAction])
    }
    
    
  
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .shows, object: nil)
    }
}


extension UIImage {
    static func buttonWithSymbolConfiguration(systemName: String, color: UIColor, font: UIFont.TextStyle = .title3) -> UIImage {
        UIImage(systemName: systemName, withConfiguration: UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .title2)).applying(UIImage.SymbolConfiguration(weight: .bold)))!
     }
}
