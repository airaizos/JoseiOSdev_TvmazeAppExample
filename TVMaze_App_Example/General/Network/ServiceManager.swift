//
//  ServiceManager.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 20/03/24.
//

import Foundation

class ServiceManager {
    typealias MethodHandler1 = (_ sampleParameter: Data) -> Void
    typealias MethodHandler2 = (_ sampleParameter: String) -> Void
    let timeInterval = 30
    
    fileprivate func handle(response: URLResponse?, data: Data?, error: Error?, correctAnswerHandler: @escaping MethodHandler1, incorrectAnswerHandler: @escaping MethodHandler2) {
        if let error = error {
            self.errorHandle(error: error, incorrectAnswerHandler: incorrectAnswerHandler)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            incorrectAnswerHandler("Invalid response")
            return
        }
        
        guard let data = data else {
            incorrectAnswerHandler("No data")
            return
        }
        
        switch httpResponse.statusCode {
        case 200..<300:
            correctAnswerHandler(data)
        case 400..<500:
            incorrectAnswerHandler("Client error \(httpResponse.statusCode)")
        case 500..<600:
            incorrectAnswerHandler("Server error \(httpResponse.statusCode)")
        default:
            incorrectAnswerHandler("Unexpected response code: \(httpResponse.statusCode)")
        }
    }
    
    fileprivate func errorHandle(error:Error, incorrectAnswerHandler: @escaping MethodHandler2) {
        if let urlError = error as? URLError {
            if urlError.code == .notConnectedToInternet {
                incorrectAnswerHandler("No internet connection")
            } else {
                incorrectAnswerHandler(error.localizedDescription)
            }
        } else {
            incorrectAnswerHandler(error.localizedDescription)
        }
        return
    }
    
    func requestGet(url:String, correctAnswerHandler: @escaping MethodHandler1, incorrectAnswerHandler: @escaping MethodHandler2) {
        guard let url = URL(string: url) else {
            incorrectAnswerHandler("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = TimeInterval(self.timeInterval)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            self.handle(response: response, data: data, error: error, correctAnswerHandler: correctAnswerHandler, incorrectAnswerHandler: incorrectAnswerHandler)
            
        }.resume()
    }
    
    deinit {
        debugPrint("<<<\(self)>>>")
    }
}
