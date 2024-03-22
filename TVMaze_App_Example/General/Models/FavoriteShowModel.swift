//
//  FavoriteShowModel.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 22/03/24.
//

import Foundation
import CoreData

class FavoriteShowModel: NSObject {
    var id:Int?
    var imageMedium:String?
    var imageOriginal:String?
    var imdbURL:String?
    var name:String?
    var resume:String?
    
    init(id:Int,show:ShowModel) {
        self.id = id
        self.imageMedium = show.image?.medium ?? ""
        self.imageOriginal = show.image?.original ?? ""
        self.imdbURL = show.externals?.imdb ?? ""
        self.name = show.name ?? ""
        self.resume = show.summary ?? ""
    }
    
    init(show: FavoriteShow) {
        self.id = Int(show.id)
        self.imageMedium = show.imageMedium ?? ""
        self.imageOriginal = show.imageOriginal ?? ""
        self.imdbURL = show.imdbURL ?? ""
        self.name = show.name ?? ""
        self.resume = show.resume ?? ""
    }
    
    deinit {
        debugPrint("<<<\(self)>>>")
    }
}
