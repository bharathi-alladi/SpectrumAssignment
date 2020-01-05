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
    
    var viewModel : CompaniesListViewModel!
    
    class func initWithViewModel(_ viewModel: CompaniesListViewModel) -> CompaniesListViewController {
        
        let storyBoard = UIStoryboard.init(name: STRING_CONSTANTS.MAIN, bundle: nil)
        let vcObj = storyBoard.instantiateViewController(withIdentifier: VIEW_CONTROLLER_CONSTANTS.COMPANIES_LIST) as! CompaniesListViewController
        vcObj.viewModel = viewModel
        vcObj.viewModel.viewController = vcObj
        return vcObj
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = STRING_CONSTANTS.COMPANIES
        self.company_tableView.dataSource = self
        self.company_tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        self.activityIndicator.startAnimating()
        self.viewModel.fetchCompaniesData()
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

}

extension CompaniesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel!.getRowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CompanyTableViewCell = tableView.dequeueReusableCell(withIdentifier: VIEW_CONSTANTS.COMPANY_TABLE_CELL) as! CompanyTableViewCell
        
        let company = self.viewModel.getContact(index: indexPath.row)
        
        cell.companiesIcons.image(urlString: company.logo, withPlaceHolder: UIImage.init(named: ""), doOverwrite: false)
        cell.companiesIcons.layer.borderWidth = 1
        cell.companiesIcons.layer.masksToBounds = false
        cell.companiesIcons.layer.borderColor = UIColor.init(named: ASSET_CONSTANTS.APP_COLOR)!.cgColor
        cell.companiesIcons.layer.cornerRadius = cell.companiesIcons.frame.height/2
        cell.companiesIcons.clipsToBounds = true
        
        cell.companynameLable.text = company.company
        return cell
    }
}

extension CompaniesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.rowSelected(indexPath.row)
    }
    
}

