//
//  Service manager.swift
//  Spectrum
//
//  Created by Chandrika Alladi on 30/12/19.
//  Copyright © 2019 Harsha Vardhan Pabbineedi. All rights reserved.
//

import Foundation

struct ServiceManager {
        
        func getCompaniesList (onSuccess returnBlock:@escaping (([Company]?, Error?) -> Void))
        {
            
            let url = URL.init(string: NetworkConstants.BASE_URL)
            let urlRequest = URLRequest.init(url: url!)
            
            let defaultConfiq = URLSessionConfiguration.default
            let urlSession = URLSession.init(configuration : defaultConfiq)
            
            let dataTask = urlSession.dataTask(with: urlRequest, completionHandler: {
                (data, urlResponse, error) in
                
                let httpResponse = urlResponse as! HTTPURLResponse
                
                if httpResponse.statusCode == 200 {
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
            dataTask.resume()
        }
}
