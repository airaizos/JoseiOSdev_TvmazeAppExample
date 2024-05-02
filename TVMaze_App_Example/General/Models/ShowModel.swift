//
//  ShowModel.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 20/03/24.
//

import Foundation

struct ShowModel: Codable, Identifiable, Hashable,Equatable {
    let id: Int?
    let url: String?
    let name: String?
    let type: String?
    let language: String?
    let genres: [String]?
    let status: String?
    let runtime: Int?
    let averageRuntime: Int?
    let premiered: String?
    let officialSite: String?
    let schedule: Schedule?
    let rating: Rating?
    let weight: Int?
    let network: Network?
    let externals: Externals?
    let image: Image?
    let summary: String?
    let updated: Int?
    let links: Links?  
}
