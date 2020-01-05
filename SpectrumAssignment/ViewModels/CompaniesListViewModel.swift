//
//  CompaniesListViewModel.swift
//  SpectrumAssignment
//
//  Created by Chandrika Alladi on 30/12/19.
//  Copyright © 2019 Alladi Satya Chandra Bharathi. All rights reserved.
//

import Foundation

class CompaniesListViewModel  {
    
    var dataSource:[Company] = []
    var viewController : CompaniesListViewController?
    
    private var _sortedData:[Company] = []
    private var _searchString:String = ""
    private var _isAscending:Bool = true
    private var _isSearchEnabled:Bool = false
    
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
                self._sortedData = Utilities.init().searchAndSort(companies: self.dataSource, with: self._searchString, isAscending: self._isAscending)
                self.viewController?.reloadTableView()
            }
            else {
                self.viewController?.displayAlert(with: error)
            }
        })
    }
    
    func sortUpdated(_ isAscending:Bool) {
        self._isAscending = isAscending
        
        self._sortedData = Utilities().searchAndSort(companies: self.dataSource, with: self._searchString, isAscending: _isAscending)
        self.viewController?.reloadTableView()
    }
    
    func updateResults(with searchString: String, isSearchEnabled: Bool) {
        
        self._isSearchEnabled = isSearchEnabled
        if isSearchEnabled {
            self._searchString = searchString
        } else {
            self._searchString = ""
        }
        self._sortedData = Utilities().searchAndSort(companies: self.dataSource, with: self._searchString, isAscending: _isAscending)
        self.viewController?.reloadTableView()
    }
    
    //MARK:- table cell helper functions
    func companyUpdated(for company:Company) {
        var index = 0
        for company1 in dataSource {
            if company1.company == company.company {
                break
            }
            index += 1
        }
        self.dataSource.remove(at: index)
        self.dataSource.append(company)
        self._sortedData = Utilities().searchAndSort(companies: self.dataSource, with: self._searchString, isAscending: _isAscending)
    }
    
    //MARK:- viewController helper functions
    func isSearchEnabled() -> Bool {
        return _isSearchEnabled
    }
    
    func isAscending() -> Bool {
        return _isAscending
    }
    
    func getRowCount() -> Int {
        return _sortedData.count
    }
    
    func getCompany(index:Int) -> Company {
        
        return _sortedData[index]
    }
    
    //MARK:- routing functions
    func rowSelected(_ index : Int) {
        
        // get the index's element from company list data
        let companyDetails = _sortedData[index]
        // with this data, call router's navigate to detailView
        Router.sharedInstance.navigateToCompanyDetails(companyDetails)
    }
}

