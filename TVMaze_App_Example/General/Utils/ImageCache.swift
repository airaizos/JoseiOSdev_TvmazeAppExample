//
//  ImageCache.swift
//  TVMaze_App_Example
//
//  Created by José Caballero on 20/03/24.
//

import UIKit

class ImageCache: NSObject {
    static let sharedCache: NSCache = { () -> NSCache<AnyObject, AnyObject> in
        let cache = NSCache<AnyObject, AnyObject>()
        cache.name = "MyImageCache"
        cache.countLimit = 50 // Max 50 images in memory.
        cache.totalCostLimit = 50*1024*1024 // Max 50MB used.
        return cache
    }()
    static let imageCache = NSCache<AnyObject, AnyObject>()
    static var images = Array<UIImage>()
}

extension UIImageView{
    
    func imageFromUrl(urlString: String, force: Bool, placeholder: UIImage?, completion: ((_ image:UIImage?) -> Void)? = nil) {
        
        let urlStringRemplace = urlString.replacingOccurrences(of: " ", with: "")
        self.image = nil
        if force {//yo movi para evitar el borrado siempre
            ImageCache.sharedCache.removeObject(forKey: urlStringRemplace as AnyObject)
        }
        //    self.image = placeholder ?? #imageLiteral(resourceName: "imagePlaceholder")
        if #available(iOS 13.0, *) {
            self.image = placeholder ?? UIImage(systemName: "photo.fill")
        } else {
            self.image = UIImage(named: "placeHolderImage")
        }
        if force {
            if let url = URL(string: urlStringRemplace) {
                URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
                    if error != nil {
                        debugPrint("<<<<< imageCacheError: \(String(describing: error))")
                        return
                    }
                    DispatchQueue.main.async(execute: { () -> Void in
                        let image = UIImage(data: data!)
                        //                        self.contentMode = .scaleAspectFit
                        self.image = image
                        if completion != nil {
                            completion!(image)
                        }
                        if(image != nil){
                            ImageCache.sharedCache.setObject(image!, forKey: urlStringRemplace as AnyObject)
                        }
                    }
                    )
                }).resume()
            }
        } else {
            if let cachedImage = ImageCache.sharedCache.object(forKey: urlStringRemplace as AnyObject) as? UIImage {
                //                self.contentMode = .scaleAspectFit
                self.image = cachedImage
                if completion != nil {
                    completion!(self.image)
                }
                return
            } else {
                //TODO: Cambiar
                URLSession.shared.dataTask(with: NSURL(string: urlStringRemplace)! as URL, completionHandler: { (data, response, error) -> Void in
                    if error != nil {
                        return
                    }
                    DispatchQueue.main.async(execute: { () -> Void in
                        let image = UIImage(data: data!)
                        //                        self.contentMode = .scaleAspectFit
                        self.image = image
                        if completion != nil {
                            completion!(image)
                        }
                        if image != nil {
                            ImageCache.sharedCache.setObject(image!, forKey: urlStringRemplace as AnyObject)
                        }
                    }
                    )
                }).resume()
            }
        }
    }
    
}


extension Notification.Name {
    static let shows = Notification.Name("SHOW")
    static let favorites = Notification.Name("FAVORITE")
    
}
