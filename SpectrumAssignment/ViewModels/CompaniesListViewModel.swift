//
//  CompaniesListViewModel.swift
//  SpectrumAssignment
//
//  Created by Chandrika Alladi on 30/12/19.
//  Copyright © 2019 Alladi Satya Chandra Bharathi. All rights reserved.
//

import Foundation

class CompaniesListViewModel  {
    
    var companyListData : [Company] = []
    var viewController : CompaniesListViewController?
    
    init() {
        
    }
    
    func fetchCompaniesData() {
        let serviceManager = ServiceManager.init()
        serviceManager.getCompaniesList(onSuccess: {
            (companyListData, error) in
            
            if companyListData != nil {
                self.companyListData = companyListData!
                self.viewController?.reloadTableView()
            }
            else {
                self.viewController?.displayAlert(with: error)
            }
        })
    }
    
    func getRowCount() -> Int {
        return companyListData.count
    }
    
    func getContact(index:Int) -> Company {
        
        return companyListData[index]
    }
    
}

