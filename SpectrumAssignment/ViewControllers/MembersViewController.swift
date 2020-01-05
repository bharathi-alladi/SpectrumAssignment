//
//  MembersViewController.swift
//  SpectrumAssignment
//
//  Created by Chandrika Alladi on 6/1/20.
//  Copyright © 2020 Alladi Satya Chandra Bharathi. All rights reserved.
//

import UIKit

class MembersViewController: UIViewController {

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var members_tableView : UITableView!
    
    var viewModel : ListViewModel!
    var searchController:UISearchController!
    
    class func initWithViewModel(_ viewModel: ListViewModel) -> MembersViewController {
        
        let storyBoard = UIStoryboard.init(name: STRING_CONSTANTS.MAIN, bundle: nil)
        let vcObj = storyBoard.instantiateViewController(withIdentifier: VIEW_CONTROLLER_CONSTANTS.MEMBERS_LIST) as! MembersViewController
        vcObj.viewModel = viewModel
        vcObj.viewModel.membersViewController = vcObj
        return vcObj
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = STRING_CONSTANTS.MEMBERS
        self.members_tableView.dataSource = self
        self.members_tableView.delegate = self
        
        if viewModel.getMemberRowCount() == 0 {
            self.activityIndicator.startAnimating()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.attachSearchController()
        let rightBarButton = UIBarButtonItem.init(title: STRING_CONSTANTS.SORT, style: .plain, target: self, action: #selector(MembersViewController.sortBtnAction))
        self.tabBarController!.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    // MARK: - custom functions
    func reloadTableView() {
        DispatchQueue.main.async(execute: {() -> Void in
            if self.isViewLoaded {
                self.activityIndicator.stopAnimating()
                self.members_tableView.reloadData()
            }
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
        let alertAction3Style:UIAlertAction.Style!
        let alertAction4Style:UIAlertAction.Style!
        let memberSortType = viewModel.getMemberSortBy()
        
        switch memberSortType {
        case .nameAscending:
            alertAction1Style = UIAlertAction.Style.destructive
            alertAction2Style = UIAlertAction.Style.default
            alertAction3Style = UIAlertAction.Style.default
            alertAction4Style = UIAlertAction.Style.default
            break
        case .nameDescending:
            alertAction1Style = UIAlertAction.Style.default
            alertAction2Style = UIAlertAction.Style.destructive
            alertAction3Style = UIAlertAction.Style.default
            alertAction4Style = UIAlertAction.Style.default
            break
        case .ageAscending:
            alertAction1Style = UIAlertAction.Style.default
            alertAction2Style = UIAlertAction.Style.default
            alertAction3Style = UIAlertAction.Style.destructive
            alertAction4Style = UIAlertAction.Style.default
            break
        default:
            alertAction1Style = UIAlertAction.Style.default
            alertAction2Style = UIAlertAction.Style.default
            alertAction3Style = UIAlertAction.Style.default
            alertAction4Style = UIAlertAction.Style.destructive
            break
        }
        
        let userActionSheet = UIAlertController.init(title: STRING_CONSTANTS.SORT_MEMBERS, message: nil, preferredStyle: .actionSheet)
        let alertAction1 = UIAlertAction.init(title: STRING_CONSTANTS.SORT_MEMBER_NAME_ASCENDING, style: alertAction1Style) { (alertAction) in
            self.viewModel.sortMembersUpdated(.nameAscending)
        }
        userActionSheet.addAction(alertAction1)
        let alertAction2 = UIAlertAction.init(title: STRING_CONSTANTS.SORT_MEMBER_NAME_DESCENDING, style: alertAction2Style) { (alertAction) in
            self.viewModel.sortMembersUpdated(.nameDescending)
        }
        userActionSheet.addAction(alertAction2)
        let alertAction3 = UIAlertAction.init(title: STRING_CONSTANTS.SORT_MEMBER_AGE_ASCENDING, style: alertAction3Style) { (alertAction) in
            self.viewModel.sortMembersUpdated(.ageAscending)
        }
        userActionSheet.addAction(alertAction3)
        let alertAction4 = UIAlertAction.init(title: STRING_CONSTANTS.SORT_MEMBER_AGE_DESCENDING, style: alertAction4Style) { (alertAction) in
            self.viewModel.sortMembersUpdated(.ageDescending)
        }
        userActionSheet.addAction(alertAction4)
        self.present(userActionSheet, animated: true, completion: nil)
    }
}

extension MembersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel!.getMemberRowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : MembersViewCell = tableView.dequeueReusableCell(withIdentifier: VIEW_CONSTANTS.MEMBER_TABLE_CELL) as! MembersViewCell
        let member = self.viewModel.getMember(index: indexPath.row)
        cell.configUI(member: member, viewModel: viewModel)
        return cell
    }
}

extension MembersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.memberRowSelected(indexPath.row)
    }
}

extension MembersViewController {
    
    func attachSearchController() {

        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.sizeToFit()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        self.tabBarController!.navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

extension MembersViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text ?? ""
        viewModel.updateMemberResults(with: searchString, isSearchEnabled: true)
    }
}

extension MembersViewController: UISearchControllerDelegate {
    
    func didDismissSearchController(_ searchController: UISearchController) {
        viewModel.updateMemberResults(with: "", isSearchEnabled: false)
    }
}


