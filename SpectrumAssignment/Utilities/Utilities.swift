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
    
    // MARK: - searchAndSort members
    func searchAndSort(members:[Member], with searchString:String, membersSortBy:MembersSortBy) -> [Member] {
        let searchMembers = self._search(members: members, with: searchString)
        
        switch membersSortBy {
        case .nameAscending:
            let sortedMembers = searchMembers.sorted(by: { $0.fullName() < $1.fullName() })
            return sortedMembers
        case .nameDescending:
            var sortedMembers = searchMembers.sorted(by: { $0.fullName() < $1.fullName() })
            sortedMembers.reverse()
            return sortedMembers
        case .ageAscending:
            let sortedMembers = searchMembers.sorted(by: { $0.age < $1.age })
            return sortedMembers
        default:
            var sortedMembers = searchMembers.sorted(by: { $0.age < $1.age })
            sortedMembers.reverse()
            return sortedMembers
        }
    }
    
    func getAllMemeber(companies:[Company]) -> [Member] {
        
        var allMembers:[Member] = []
        for company in companies {
            allMembers.append(contentsOf: company.members)
        }
        return allMembers
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
