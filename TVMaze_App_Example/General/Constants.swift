//
//  Constants.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 20/03/24.
//

import Foundation
import UIKit

class Constants {
    static let APP_TITLE = "Oops,algosaliómal!"//TVMaze_App_Example"
    static let DATA_BASE = "TVMaze_App_Example"
    static let SERVER_PRODUCTION_URL_PORT = "https://api.tvmaze.com"
    static let SERVER_TEST_URL_PORT = "https://api.tvmaze.com"
    static let SERVER_PLATFORM_HEADER = "iOS"
    static let APP_VERSION:String = {
        let path = Bundle.main.url(forResource: "Info", withExtension: "plist")
        let dic = NSDictionary(contentsOf: path!) as? [String: Any]
        let shortVersion:String=dic?["CFBundleShortVersionString"] as? String ?? ""
        let buildVersion:String=dic?["CFBundleVersion"] as? String ?? ""
        return (shortVersion)
    }()
    static var UUID_DEVICE:String {
        if let uuid = UIDevice.current.identifierForVendor?.uuidString {
            return uuid
        } else {
            return ""
        }
    }
    static let IS_IPAD_DEVICE:Bool = UIDevice.current.userInterfaceIdiom == .pad
    static let DEVICE_TYPE:UIUserInterfaceIdiom = UIDevice.current.userInterfaceIdiom
    
    static let ENTITY:String = "FavoriteShow"
}
