//
//  Network.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 20/03/24.
//

import Foundation

struct Network: Codable,Hashable {
    let id: Int?
    let name: String?
    let country: Country?
    let officialSite: String?
}
