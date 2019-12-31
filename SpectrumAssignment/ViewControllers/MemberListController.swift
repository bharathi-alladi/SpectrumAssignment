//
//  MemberListController.swift
//  SpectrumAssignment
//
//  Created by Chandrika Alladi on 31/12/19.
//  Copyright © 2019 Alladi Satya Chandra Bharathi. All rights reserved.
//

import UIKit

class MemberListController: UIViewController {
    
    @IBOutlet var member_tableView : UITableView!
    
    var viewModel : CompanyDetailViewModel!
    
    class func initWithViewModel(_ viewModel: CompanyDetailViewModel) -> MemberListController {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vcObj = storyBoard.instantiateViewController(withIdentifier: "MemberListController") as! MemberListController
        vcObj.viewModel = viewModel
        vcObj.viewModel.memberListController = vcObj
        return vcObj
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.member_tableView.delegate = self
        self.member_tableView.dataSource = self
    }
}

extension MemberListController : UITableViewDelegate {
    
}



extension MemberListController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell")
        cell?.textLabel!.text = viewModel.getMemberTitle(indexPath.row)
        return cell!
    }
    
    
}
