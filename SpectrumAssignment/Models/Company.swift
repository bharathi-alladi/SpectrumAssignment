//
//  CompanyDataModel.swift
//  Spectrum
//
//  Created by Chandrika Alladi on 30/12/19.
//  Copyright © 2019 Harsha Vardhan Pabbineedi. All rights reserved.
//

import Foundation

struct Company : Codable {
    
    var _id : String!
    var company : String!
    var website : String!
    var logo : String!
    var about :String!
    var members : [Member]!
    
}
