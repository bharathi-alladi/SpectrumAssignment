//
//  ViewController.swift
//  SpectrumAssignment
//
//  Created by Chandrika Alladi on 30/12/19.
//  Copyright © 2019 Alladi Satya Chandra Bharathi. All rights reserved.
//

import UIKit

class CompaniesListViewController: UIViewController {

    var viewModel : CompaniesListViewModel!
    
    class func initWithViewModel(_ viewModel: CompaniesListViewModel) -> CompaniesListViewController {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vcObj = storyBoard.instantiateViewController(withIdentifier: "CompaniesListViewController") as! CompaniesListViewController
        vcObj.viewModel = viewModel
        vcObj.viewModel.viewController = vcObj
        return vcObj
    }


}

