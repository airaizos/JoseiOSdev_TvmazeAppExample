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
