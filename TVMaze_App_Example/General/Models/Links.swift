//
//  Links.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 20/03/24.
//

import Foundation

struct Links: Codable {
    let selfLink: SelfLink?
    let previousEpisode: PreviousEpisode?

    enum CodingKeys: String, CodingKey {
        case selfLink = "self"
        case previousEpisode = "previousepisode"
    }
}
