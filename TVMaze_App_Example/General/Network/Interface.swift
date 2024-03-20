//
//  Interface.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 20/03/24.
//

import Foundation

class DataStore: NSObject {
    
    typealias CorrectHandler = (_ data : Data)  -> Void
    typealias ErrorHandler = (_ msg : String)  -> Void
    typealias CorrectHandlerDownloadData = (_ data:Data) -> Void
    typealias MethodHandlerProgress = (_ progress:Double) -> Void
    
    let version: String = {
        let path = Bundle.main.url(forResource: "Services", withExtension: "plist")
        let dic = NSDictionary(contentsOf: path!) as? [String: Any]
        return dic?["version"] as! String
    }()
    
    let dic: [String:Any] = {
        let path = Bundle.main.url(forResource: "Services", withExtension: "plist")
        return (NSDictionary(contentsOf: path!) as? [String: Any])!
    }()
    
    let isProduction: Bool = {
        let path = Bundle.main.url(forResource: "Enviorement", withExtension: "plist")
        let dic = NSDictionary(contentsOf: path!) as? [String: Any]
        return dic?["production"] as? Bool ?? false
    }()
    
    let isTest: Bool = {
        let path = Bundle.main.url(forResource: "Enviorement", withExtension: "plist")
        let dic = NSDictionary(contentsOf: path!) as? [String: Any]
        return dic?["test"] as? Bool ?? true
    }()
    
    var server:String{
        if isProduction==true{
            return Constants.SERVER_PRODUCTION_URL_PORT
        }
        if isTest==true{
            return Constants.SERVER_TEST_URL_PORT
        }
        return Constants.SERVER_TEST_URL_PORT
    }
    
    lazy var serviceManager =  { ServiceManager() }()
    
}
