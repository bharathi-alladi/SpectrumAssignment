//
//  Utilities.swift
//  SpectrumAssignment
//
//  Created by Chandrika Alladi on 5/1/20.
//  Copyright © 2020 Alladi Satya Chandra Bharathi. All rights reserved.
//

import UIKit

class Utilities {
    
    // MARK: - searchAndSort companies
    func searchAndSort(companies:[Company], with searchString:String, isAscending:Bool) -> [Company] {
        let searchCompanies = self._search(companies: companies, with: searchString)
        
        var sortedCompanies = searchCompanies.sorted(by: { $0.company < $1.company })
        if isAscending {
            return sortedCompanies
        }
        else {
            sortedCompanies.reverse()
            return sortedCompanies
        }
    }
    
    // MARK: - searchAndSort companies
    func searchAndSortByName(members:[Member], with searchString:String, isAscending:Bool) -> [Member] {
        let searchMembers = self._search(members: members, with: searchString)
        
        var sortedMembers = searchMembers.sorted(by: { $0.fullName() < $1.fullName() })
        if isAscending {
            return sortedMembers
        }
        else {
            sortedMembers.reverse()
            return sortedMembers
        }
    }
    
    func searchAndSortByAge(members:[Member], with searchString:String, isAscending:Bool) -> [Member] {
        let searchMembers = self._search(members: members, with: searchString)
        
        var sortedMembers = searchMembers.sorted(by: { $0.age < $1.age })
        if isAscending {
            return sortedMembers
        }
        else {
            sortedMembers.reverse()
            return sortedMembers
        }
    }
    
    //MARK:- private functions
    private func _search(companies:[Company], with searchString:String) -> [Company] {
        if searchString == "" {
            return companies
        }
        
        var searchCompanies:[Company] = []
        
        for company:Company in companies {
            if company.company.lowercased().contains(searchString.lowercased()) {
                searchCompanies.append(company)
            }
        }
        return searchCompanies
    }
    
    private func _search(members:[Member], with searchString:String) -> [Member] {
        if searchString == "" {
            return members
        }
        
        var searchMembers:[Member] = []
        
        for member:Member in members {
            if member.fullName().lowercased().contains(searchString.lowercased()) {
                searchMembers.append(member)
            }
        }
        return searchMembers
    }
}
