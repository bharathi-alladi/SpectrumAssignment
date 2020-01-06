//
//  CompanyDetailController.swift
//  SpectrumAssignment
//
//  Created by Chandrika Alladi on 31/12/19.
//  Copyright © 2019 Alladi Satya Chandra Bharathi. All rights reserved.
//

import UIKit

class CompanyDetailController: UIViewController {
    
    var viewModel : CompanyDetailViewModel!
    
    @IBOutlet var tableView:UITableView!
    
    class func initWithViewModel(_ viewModel: CompanyDetailViewModel) -> CompanyDetailController {
        
        let storyBoard = UIStoryboard.init(name: STRING_CONSTANTS.MAIN, bundle: nil)
        let vcObj = storyBoard.instantiateViewController(withIdentifier: VIEW_CONTROLLER_CONSTANTS.COMPANY_DETAIL) as! CompanyDetailController
        vcObj.viewModel = viewModel
        vcObj.viewModel.companyDetailController = vcObj
        return vcObj
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.title = viewModel.getDetails().company
    }


}

extension CompanyDetailController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 220
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 1 {
            return STRING_CONSTANTS.MEMBERS
        }
        return nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        return viewModel!.getMembersCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let details = viewModel.getDetails()
            let cell = tableView.dequeueReusableCell(withIdentifier: VIEW_CONSTANTS.COMPANY_DETAIL_CELL) as! CompanyDetailCell
            
            cell.companyPic.image(urlString: details.logo, withPlaceHolder: UIImage.init(named: ASSET_CONSTANTS.PLACEHOLDER_PIC), doOverwrite: true)
            cell.desc.text = details.about
            cell.website.text = details.website
            
            cell.companyPic.layer.borderWidth = 1
            cell.companyPic.layer.masksToBounds = false
            cell.companyPic.layer.borderColor = UIColor.init(named: ASSET_CONSTANTS.APP_COLOR)!.cgColor
            cell.companyPic.layer.cornerRadius = cell.companyPic.frame.height/2
            cell.companyPic.clipsToBounds = true
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: VIEW_CONSTANTS.COMPANY_MEMBER_CELL)!
            cell.textLabel!.text = viewModel.getMemberTitle(indexPath.row)
            return cell
        }
    }
}

extension CompanyDetailController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            viewModel.rowSelected(indexPath.row)
        }
    }
}
