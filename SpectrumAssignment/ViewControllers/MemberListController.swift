//
//  MemberListController.swift
//  SpectrumAssignment
//
//  Created by Chandrika Alladi on 31/12/19.
//  Copyright © 2019 Alladi Satya Chandra Bharathi. All rights reserved.
//

import UIKit

class MemberListController: UIViewController {
    
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
    }
}
