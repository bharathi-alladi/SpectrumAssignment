//
//  Service manager.swift
//  Spectrum
//
//  Created by Chandrika Alladi on 30/12/19.
//  Copyright © 2019 Harsha Vardhan Pabbineedi. All rights reserved.
//

import Foundation
import UIKit

struct ServiceManager {
    
    func getCompaniesList (onSuccess returnBlock:@escaping (([Company]?, Error?) -> Void)) {
        
        let url = URL.init(string: NETWORK_CONSTANTS.BASE_URL)
        let urlRequest = URLRequest.init(url: url!)
        
        self._getData(urlRequest, returnBlock: {
            (data, error) in
            
            if data != nil {
                
                let decoder = JSONDecoder.init()
                do {
                    
                    let fetchedData =  try decoder.decode([Company].self, from: data!)
                    returnBlock(fetchedData, nil)
                } catch {
                    returnBlock(nil, error)
                }
            }
            else {
                returnBlock(nil, error)
            }
        })
    }
    
    func getImage(_ urlString:String, returnBlock:@escaping ((Data?, Error?) -> Void)) {
        
        let url = URL.init(string: urlString)
        let urlRequest = URLRequest.init(url: url!)
        
        self._getData(urlRequest, returnBlock: {
            (data, error) in
            
            if data != nil {
                returnBlock(data, nil)
            }
            else {
                returnBlock(nil, error)
            }
        })
    }
    
    private func _getData(_ urlRequest:URLRequest, returnBlock:@escaping ((Data?, Error?) -> Void)) {
        
        let defaultConfiq = URLSessionConfiguration.default
        let urlSession = URLSession.init(configuration : defaultConfiq)
        
        let dataTask = urlSession.dataTask(with: urlRequest, completionHandler: {
            (data, urlResponse, error) in
            
            let httpResponse = urlResponse as! HTTPURLResponse
            if (httpResponse.statusCode >= 200) && (httpResponse.statusCode <= 206) &&
                (error == nil) && (data != nil)
            {
                returnBlock(data, nil)
            }
            else {
                if error != nil {
                    returnBlock(nil, error)
                } else {
                    
                    let customError = NSError.init(domain: ERROR_CONSTANTS.ERROR_DOMAIN,
                        code: ERROR_CONSTANTS.NIL_DATA_CODE,
                        userInfo: [NSLocalizedDescriptionKey:ERROR_CONSTANTS.NIL_DATA_DESC])
                    returnBlock(nil, customError)
                }
            }
        })
        dataTask.resume()
    }
}
