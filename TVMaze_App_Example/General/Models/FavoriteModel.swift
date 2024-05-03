//
//  FavoriteModel.swift
//  TVMaze_App_Example
//
//  Created by Adrian Iraizos Mendoza on 2/5/24.
//

import Foundation


struct FavoriteModel: Hashable {
    var id:Int
    var imageMedium:String
    var imageOriginal:String
    var imdbURL:String
    var name:String
    var resume:String
    var rating: String
    
    
    init?(show: ShowModel) {
        guard let id = show.id  else { return nil }
        self.id = id
        imageMedium = show.image?.medium ?? ""
        imageOriginal = show.image?.original ?? ""
        imdbURL = show.externals?.imdb ?? ""
        name = show.name ?? ""
        resume = show.summary ?? ""
        rating = "\(show.rating?.average ?? 0)"
    }
    
    init(show: FavoriteShow) {
        self.id = Int(show.id)
        self.imageMedium = show.imageMedium ?? ""
        self.imageOriginal = show.imageOriginal ?? ""
        self.imdbURL = show.imdbURL ?? ""
        self.name = show.name ?? ""
        self.resume = show.resume ?? ""
        self.rating = "\(show.rating)"
    }
    
}
