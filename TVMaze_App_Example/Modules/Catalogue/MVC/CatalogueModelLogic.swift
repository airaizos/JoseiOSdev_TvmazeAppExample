//
//  CatalogueModelLogic.swift
//  TVMaze_App_Example
//
//  Created by Adrian Iraizos Mendoza on 2/5/24.
//

import UIKit

final class CatalogueModelLogic {
    static let shared = CatalogueModelLogic()
    
    let network: TVMazeDataStore
    
    init(network: TVMazeDataStore = .init()) {
        self.network = network
    }
    
    private var shows = [ShowModel]() {
        didSet {
            NotificationCenter.default.post(name: .shows, object: nil)
        }
    }
    
    var snapshot: NSDiffableDataSourceSnapshot<Int,ShowModel> {
    var snapshot = NSDiffableDataSourceSnapshot<Int,ShowModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(shows, toSection: 0)
        return snapshot
    }
    
    var showsCount: Int {
        shows.count
    }
    
    func getShows() async throws {
        self.shows = try await network.getShowsAsync().sorted(by: { s1, s2 in
            s1.rating?.average ?? 0 > s2.rating?.average ?? 0
        })
    }
}
