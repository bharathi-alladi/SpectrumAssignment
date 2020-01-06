//
//  ViewController.swift
//  SpectrumAssignment
//
//  Created by Chandrika Alladi on 30/12/19.
//  Copyright © 2019 Alladi Satya Chandra Bharathi. All rights reserved.
//

import UIKit

class CompaniesListViewController: UIViewController {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var company_tableView : UITableView!
    
    var viewModel : ListViewModel!
    var searchController:UISearchController!
    
    class func initWithViewModel(_ viewModel: ListViewModel) -> CompaniesListViewController {
        
        let storyBoard = UIStoryboard.init(name: STRING_CONSTANTS.MAIN, bundle: nil)
        let vcObj = storyBoard.instantiateViewController(withIdentifier: VIEW_CONTROLLER_CONSTANTS.COMPANIES_LIST) as! CompaniesListViewController
        vcObj.viewModel = viewModel
        vcObj.viewModel.comapaniesViewController = vcObj
        return vcObj
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = STRING_CONSTANTS.COMPANIES
        self.company_tableView.dataSource = self
        self.company_tableView.delegate = self
        
        self.activityIndicator.startAnimating()
        self.viewModel.fetchCompaniesData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.attachSearchController()
        let rightBarButton = UIBarButtonItem.init(title: STRING_CONSTANTS.SORT, style: .plain, target: self, action: #selector(CompaniesListViewController.sortBtnAction))
        self.tabBarController!.navigationItem.rightBarButtonItem = rightBarButton
    }

    // MARK: - custom functions
    func reloadTableView() {
        DispatchQueue.main.async(execute: {() -> Void in
            self.activityIndicator.stopAnimating()
            self.company_tableView.reloadData()
        })
    }
    
    func displayAlert(with error:Error?)  {
        // show an alert here
        DispatchQueue.main.async(execute: {() -> Void in
            let alertController = UIAlertController.init(title: ERROR_CONSTANTS.ERROR, message: error?.localizedDescription ?? ERROR_CONSTANTS.UNKNOWN, preferredStyle: .alert)
            let alertAction = UIAlertAction.init(title: STRING_CONSTANTS.OK, style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        })
    }
    
    @objc func sortBtnAction() {
        
        let alertAction1Style:UIAlertAction.Style!
        let alertAction2Style:UIAlertAction.Style!
        let isAscending = viewModel.isCompanyAscending()
        if isAscending {
            alertAction1Style = UIAlertAction.Style.destructive
            alertAction2Style = UIAlertAction.Style.default
        } else {
            alertAction1Style = UIAlertAction.Style.default
            alertAction2Style = UIAlertAction.Style.destructive
        }
        let userActionSheet = UIAlertController.init(title: STRING_CONSTANTS.SORT_NAME, message: STRING_CONSTANTS.BY_NAME, preferredStyle: .actionSheet)
        let alertAction1 = UIAlertAction.init(title: STRING_CONSTANTS.SORT_NAME_ASCENDING, style: alertAction1Style) { (alertAction) in
            self.viewModel.sortCompanyUpdated(true)
        }
        userActionSheet.addAction(alertAction1)
        let alertAction2 = UIAlertAction.init(title: STRING_CONSTANTS.SORT_NAME_DESCENDING, style: alertAction2Style) { (alertAction) in
            self.viewModel.sortCompanyUpdated(false)
        }
        userActionSheet.addAction(alertAction2)
        self.present(userActionSheet, animated: true, completion: nil)
    }

}

extension CompaniesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel!.getCompaniesRowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : CompanyTableViewCell = tableView.dequeueReusableCell(withIdentifier: VIEW_CONSTANTS.COMPANY_TABLE_CELL) as! CompanyTableViewCell
        let company = self.viewModel.getCompany(index: indexPath.row)
        cell.configUI(company: company, viewModel: self.viewModel)
        return cell
    }
}

extension CompaniesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.companyRowSelected(indexPath.row)
    }
}

extension CompaniesListViewController {
    
    func attachSearchController() {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.sizeToFit()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = STRING_CONSTANTS.SEARCH
        self.tabBarController!.navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}


extension CompaniesListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text ?? ""
        viewModel.updateCompanyResults(with: searchString, isSearchEnabled: true)
    }
}

extension CompaniesListViewController: UISearchControllerDelegate {
    
    func didDismissSearchController(_ searchController: UISearchController) {
        viewModel.updateCompanyResults(with: "", isSearchEnabled: false)
    }
}

