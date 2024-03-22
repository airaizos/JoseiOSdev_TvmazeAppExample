//
//  Utils.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 20/03/24.
//

import Foundation
import UIKit

class Utils {
    typealias ErrorAnswer = (_ error:String) -> Void
    
    static func showSimpleAlert(title:String, message:String, controller:UIViewController, actions:[UIAlertAction], completion:(() -> Void)?){
        let alert=UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { action in
            alert.addAction(action)
        }
        controller.present(alert, animated: true, completion: completion)
    }
    
    static func openURLWithSafari(url:String, errorAnswer:@escaping ErrorAnswer){
            guard let newUrl = URL(string: url) else {
                errorAnswer("ErrorURL".localizable())
                return }
            if Utils.verifyUrl(urlString: url){
                UIApplication.shared.open(newUrl)
            }else{
                errorAnswer("ErrorURL".localizable())
                return
            }
        }
        
        static func verifyUrl (urlString: String?) -> Bool {
            if let urlString = urlString {
                if let url = URL(string: urlString) {
                    return UIApplication.shared.canOpenURL(url)
                }
            }
            return false
        }
}
