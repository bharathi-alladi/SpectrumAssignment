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
    
    class func initWithViewModel(_ viewModel: CompanyDetailViewModel) -> CompanyDetailController {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vcObj = storyBoard.instantiateViewController(withIdentifier: "CompanyDetailController") as! CompanyDetailController
        vcObj.viewModel = viewModel
        vcObj.viewModel.companyDetailController = vcObj
        return vcObj
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
