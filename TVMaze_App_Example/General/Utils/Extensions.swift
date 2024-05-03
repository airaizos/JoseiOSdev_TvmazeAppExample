//
//  Extensions.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 20/03/24.
//

import Foundation

extension String {
    func localizable() -> String {
        return NSLocalizedString(self, comment: self)
    }
}

extension Notification.Name {
    static let shows = Notification.Name("SHOW")
    static let favorites = Notification.Name("FAVORITE")
    static let detailFavorite = Notification.Name("DETAIL")
    static let errorFavorite = Notification.Name("ERRORFAVORITE")
}
