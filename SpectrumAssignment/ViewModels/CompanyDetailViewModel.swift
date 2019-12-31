//
//  CompanyDetailViewModel.swift
//  SpectrumAssignment
//
//  Created by Chandrika Alladi on 31/12/19.
//  Copyright © 2019 Alladi Satya Chandra Bharathi. All rights reserved.
//

import UIKit

class CompanyDetailViewModel {
    
    var company:Company!
    var companyDetailController : CompanyDetailController?
    var memberListController : MemberListController?
    
    init(_ company:Company) {
        self.company = company
    }

}
