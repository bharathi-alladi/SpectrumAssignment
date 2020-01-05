//
//  Member.swift
//  SpectrumAssignment
//
//  Created by Chandrika Alladi on 30/12/19.
//  Copyright © 2019 Alladi Satya Chandra Bharathi. All rights reserved.
//

import Foundation

struct Name : Codable {
    
    var first : String!
    var last : String!
}

struct Member : Codable {
    
    var _id : String!
    var age : Int!
    var name : Name!
    var email : String!
    var phone : String!
    var isFavourite: Bool?
}
