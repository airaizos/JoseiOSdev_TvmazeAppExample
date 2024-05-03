//
//  TVMazeDataStore.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 20/03/24.
//

import UIKit

class TVMazeDataStore: DataStore {
    var controller:TVMazeViewController?
    
    override init(urlProtocol: URLProtocol.Type? = nil) {
        super.init()
        self.urlProtocol = urlProtocol
    }
    
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
    
    func getShowsAsync() async throws -> [ShowModel] {
        try await withCheckedThrowingContinuation { continuation in
            
            getShows { data in
                do {
                    let decodedData = try JSONDecoder().decode([ShowModel].self, from: data)
                    continuation.resume(returning: decodedData)
                    
                } catch let error {
                    continuation.resume(throwing: error)
                }
            } errorAnswer: { msg in
                continuation.resume(throwing: Error.self as! Error)
            }
        }
    }
    
    func getShow(id:Int, correctAnswer: @escaping CorrectHandler, errorAnswer: @escaping ErrorHandler) {
        let servicePrefix = dic["getShows"] as! String
        let webService = server + version + servicePrefix + "/\(id)"
        self.serviceManager.requestGet(url: webService, correctAnswerHandler: correctAnswer, incorrectAnswerHandler: errorAnswer)
    }
    
    func getShowAsync(id: Int) async throws -> ShowModel {
        try await withCheckedThrowingContinuation { continuation in
            
            getShow(id: id) { data in
                do {
                    let decodedData = try JSONDecoder().decode(ShowModel.self, from: data)
                    continuation.resume(returning: decodedData)
                    
                } catch let error {
                    continuation.resume(throwing: error)
                }
            } errorAnswer: { msg in
                continuation.resume(throwing: Error.self as! Error)
            }
        }
    }
}


