//
//  TVMazeDataStore.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 20/03/24.
//

import UIKit

class TVMazeDataStore: DataStore {
    var controller:TVMazeViewController?
    
    override init() {}
    
    init(_ controller:TVMazeViewController?) {
        if controller != nil{
            self.controller=controller
            controller!.showLoader()
        }
    }
    
    
    func getShows(correctAnswer: @escaping CorrectHandler, errorAnswer: @escaping ErrorHandler) {
        let servicePrefix = dic["getShows"] as! String
        let webService = server + version + servicePrefix
        
        self.serviceManager.requestGet(url: webService, correctAnswerHandler: correctAnswer, incorrectAnswerHandler: errorAnswer)
        
    }
    
}
