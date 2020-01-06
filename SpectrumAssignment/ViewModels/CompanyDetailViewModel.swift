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
    
    init(_ company:Company) {
        self.company = company
    }
    
    func getDetails() -> Company {
        
        return company
    }
    
    func getMembersCount() -> Int {
        
        return company.members.count
    }
    
    func getMemberTitle(_ index : Int) -> String {
        
        let member = company.members[index]
        return member.fullName()
    }
    
    func rowSelected(_ index : Int) {
        
        let memberDetails = company.members[index]
        Router.sharedInstance.navigateToMemberDetails(_member: memberDetails)
    }

}
