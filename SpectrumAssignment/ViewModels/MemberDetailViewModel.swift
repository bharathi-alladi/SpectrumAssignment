//
//  MemberDetailViewModel.swift
//  SpectrumAssignment
//
//  Created by Chandrika Alladi on 1/1/20.
//  Copyright © 2020 Alladi Satya Chandra Bharathi. All rights reserved.
//

import UIKit

class MemberDetailViewModel {
    
    var viewController : MemberDetailsController?
    var member : Member!
    
    init(_ member:Member) {
        self.member = member
    }
    
  
    func getMemberDetails()  -> Member {
         return member
    }
}
