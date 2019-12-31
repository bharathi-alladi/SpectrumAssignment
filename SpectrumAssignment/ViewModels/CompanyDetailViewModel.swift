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
    
    func getDetails() -> Company {
        
        return company
    }
    
    func getRowCount() -> Int {
        
        return company.members.count
    }
    
    func getMemberTitle(_ index : Int) -> String {
        
        let member = company.members[index]
        let name = member.name
        let fullName = (name?.first ?? "") + " " + (name?.last ?? "")
        return fullName
    }

}
