//
//  CompaniesListViewModel.swift
//  SpectrumAssignment
//
//  Created by Chandrika Alladi on 30/12/19.
//  Copyright © 2019 Alladi Satya Chandra Bharathi. All rights reserved.
//

import Foundation

enum MembersSortBy:String {
    
    case nameAscending
    case nameDescending
    case ageAscending
    case ageDescending
}

class ListViewModel  {
    
    var dataSource:[Company] = []
    
    var comapaniesViewController : CompaniesListViewController?
    var membersViewController : MembersViewController?
    
    private var _companiesSorted:[Company] = []
    private var _membersSorted:[Member] = []
    
    private var _companySearchString:String = ""
    private var _isCompanyAscending:Bool = true
    private var _isCompanySearchEnabled:Bool = false
    
    private var _membersSearchString:String = ""
    private var _membersSortBy:MembersSortBy = .nameAscending
    private var _isMembersSearchEnabled:Bool = false
    
    //MARK:- initiliser functions
    init() {
        
    }
    
    //MARK:- datasource functions
    func fetchCompaniesData() {
        let serviceManager = ServiceManager.init()
        serviceManager.getCompaniesList(onSuccess: {
            (companyListData, error) in
            
            if companyListData != nil {
                self.dataSource = companyListData!
                let utility = Utilities.init()
                self._companiesSorted = utility.searchAndSort(companies: self.dataSource, with: self._companySearchString, isAscending: self._isCompanyAscending)
                self.comapaniesViewController?.reloadTableView()
                
                let allMembers = utility.getAllMemeber(companies: self.dataSource)
                self._membersSorted = utility.searchAndSort(members: allMembers, with: self._membersSearchString, membersSortBy: self._membersSortBy)
                self.membersViewController?.reloadTableView()
            }
            else {
                self.comapaniesViewController?.displayAlert(with: error)
            }
        })
    }
    
    //MARK:- company datasource update functions
    func sortCompanyUpdated(_ isAscending:Bool) {
        self._isCompanyAscending = isAscending
        
        self._companiesSorted = Utilities().searchAndSort(companies: self.dataSource, with: self._companySearchString, isAscending: _isCompanyAscending)
        self.comapaniesViewController?.reloadTableView()
    }
    
    func updateCompanyResults(with searchString: String, isSearchEnabled: Bool) {
        
        self._isCompanySearchEnabled = isSearchEnabled
        if isSearchEnabled {
            self._companySearchString = searchString
        } else {
            self._companySearchString = ""
        }
        self._companiesSorted = Utilities().searchAndSort(companies: self.dataSource, with: self._companySearchString, isAscending: _isCompanyAscending)
        self.comapaniesViewController?.reloadTableView()
    }
    
    //MARK:- members datasource update functions
    func sortMembersUpdated(_ memberSortBy:MembersSortBy) {
        self._membersSortBy = memberSortBy
        
        let utility = Utilities.init()
        let allMembers = utility.getAllMemeber(companies: self.dataSource)
        self._membersSorted = utility.searchAndSort(members: allMembers, with: _membersSearchString, membersSortBy: self._membersSortBy )
        self.membersViewController?.reloadTableView()
    }
    
    func updateMemberResults(with searchString: String, isSearchEnabled: Bool) {
        
        self._isMembersSearchEnabled = isSearchEnabled
        if isSearchEnabled {
            self._membersSearchString = searchString
        } else {
            self._membersSearchString = ""
        }
        let utility = Utilities.init()
        let allMembers = utility.getAllMemeber(companies: self.dataSource)
        self._membersSorted = utility.searchAndSort(members: allMembers, with: _membersSearchString, membersSortBy: _membersSortBy)
        self.membersViewController?.reloadTableView()
    }
    
    //MARK:- table cell helper functions
    func companyUpdated(for company:Company) {
        var index = 0
        for company1 in dataSource {
            if company1._id == company._id {
                break
            }
            index += 1
        }
        self.dataSource.remove(at: index)
        self.dataSource.append(company)
        self._companiesSorted = Utilities().searchAndSort(companies: self.dataSource, with: self._companySearchString, isAscending: _isCompanyAscending)
    }
    
    //MARK:- table cell helper functions
    func memberUpdated(for member:Member) {
        
        var companyIndex = 0
        var memberIndex = 0
        for company in dataSource {
            
            var isBroken = false
            memberIndex = 0
            for member1 in company.members {
                
                if member._id == member1._id {
                    isBroken = true
                    break
                }
                memberIndex += 1
            }
            
            if isBroken {
                break
            }
            companyIndex += 1
        }
        
        var company = self.dataSource[companyIndex]
        var members:[Member] = company.members
        self.dataSource.remove(at: companyIndex)
        members.remove(at: memberIndex)
        members.append(member)
        company.members = members
        self.dataSource.append(company)
        
        let utility = Utilities.init()
        let allMembers = utility.getAllMemeber(companies: self.dataSource)
        self._membersSorted = utility.searchAndSort(members: allMembers, with: _membersSearchString, membersSortBy: _membersSortBy)
    }
    
    //MARK:- companises viewController helper functions
    func isCompanyAscending() -> Bool {
        return _isCompanyAscending
    }
    
    func getCompaniesRowCount() -> Int {
        return _companiesSorted.count
    }
    
    func getCompany(index:Int) -> Company {
        
        return _companiesSorted[index]
    }
    
    //MARK:- companises viewController helper functions
    func getMemberSortBy() -> MembersSortBy {
        return _membersSortBy
    }
    
    func getMemberRowCount() -> Int {
        return _membersSorted.count
    }
    
    func getMember(index:Int) -> Member {
        
        return _membersSorted[index]
    }
    
    //MARK:- routing functions
    func companyRowSelected(_ index : Int) {
        
        // get the index's element from company list data
        let companyDetails = _companiesSorted[index]
        // with this data, call router's navigate to detailView
        Router.sharedInstance.navigateToCompanyDetails(companyDetails)
    }
    
    func memberRowSelected(_ index: Int)  {
        
        let member = _membersSorted[index]
        Router.sharedInstance.navigateToMemberDetails(_member: member)
    }
}

