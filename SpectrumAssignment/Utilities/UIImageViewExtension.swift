//
//  UIImageViewExtension.swift
//  SpectrumAssignment
//
//  Created by Chandrika Alladi on 5/1/20.
//  Copyright © 2020 Alladi Satya Chandra Bharathi. All rights reserved.
//

import UIKit

extension UIImageView {
    static var urlCacheImages:NSCache<AnyObject, AnyObject>?
    
    func clearImageCacher() {
        
        UIImageView.urlCacheImages?.removeAllObjects()
    }
    
    func deleteCachedImage(urlString:String) {
        
        if((UIImageView.urlCacheImages?.object(forKey: urlString as AnyObject)) != nil) {
            UIImageView.urlCacheImages?.removeObject(forKey: urlString as AnyObject)
        }
    }
    
    func image(urlString:String, withPlaceHolder placeHolderImage:UIImage?, doOverwrite:Bool) {
        
        if(UIImageView.urlCacheImages == nil) {
            UIImageView.urlCacheImages = NSCache()
        }
        
        if(doOverwrite || ((UIImageView.urlCacheImages?.object(forKey: urlString as AnyObject)) == nil)) {
            
            if placeHolderImage != nil {
                self.image = placeHolderImage
                self.contentMode = .scaleAspectFit
            }
            ServiceManager.init().getImage(urlString) {
                (data, error) in
                
                if data != nil {
                    DispatchQueue.main.async(execute: {() -> Void in
                        self.image = UIImage.init(data: data!)
                        self.contentMode = .scaleAspectFit
                        UIImageView.urlCacheImages?.setObject(data as AnyObject, forKey: urlString as AnyObject)
                    })
                }
            }
        }
        else {
            
            self.image = UIImage.init(data: UIImageView.urlCacheImages?.object(forKey: urlString as AnyObject) as! Data)
        }
    }
}
