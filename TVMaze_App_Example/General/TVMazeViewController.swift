//
//  TVMazeViewController.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 20/03/24.
//

import UIKit

class TVMazeViewController: UIViewController, ViewProtocol {
    var presenter: PresenterProtocol?
    var loaderActicity: UIActivityIndicatorView!
    let appDelegate=UIApplication.shared.delegate as! AppDelegate
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        debugPrint("<<<<<< memory warning")
    }
    
    func showLoader() {
        var sc: UIWindow? = self.view.window

        if #available(iOS 13.0, *) {
            sc=UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        } else {
            sc = UIApplication.shared.keyWindow
        }
        if self.loaderActicity != nil {
            self.removeLoader()
        }
        self.loaderActicity = UIActivityIndicatorView()
        self.loaderActicity?.frame = sc?.frame ?? UIScreen.main.bounds //self.view.frame
        self.loaderActicity?.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.25)
        self.loaderActicity.color = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        self.loaderActicity?.startAnimating()
        
        if self.navigationController?.isNavigationBarHidden ?? true == false {
            self.navigationController?.navigationBar.addSubview(self.loaderActicity)
        }else{
            self.view.addSubview(self.loaderActicity!)
        }
    }
    
   func removeLoader() {
        if(self.loaderActicity != nil){
            DispatchQueue.main.async{
                self.loaderActicity?.removeFromSuperview()
                self.loaderActicity = nil
            }
        }
    }
    
    func observerError(_ error:String) {
        
        DispatchQueue.main.async {
            self.removeLoader()
            let okAction = UIAlertAction(title: "ok", style: .default)
            Utils.showSimpleAlert(title: Constants.APP_TITLE, message: error, controller: self, actions: [okAction], completion: nil)
        }
    }
    
    func showMessage(title: String? = nil, _ message:String, actions:[UIAlertAction], completion:(() -> Void)?) {
        DispatchQueue.main.async {
            self.removeLoader()
            Utils.showSimpleAlert(title: title ?? Constants.APP_TITLE, message: message, controller: self, actions: actions, completion: completion)
        }
    }

    deinit {
        debugPrint("<<<\(self)>>>")
    }

}
