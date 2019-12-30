//
//  Router.swift
//  SpectrumAssignment
//
//  Created by Chandrika Alladi on 30/12/19.
//  Copyright © 2019 Alladi Satya Chandra Bharathi. All rights reserved.
//

import UIKit

class Router {
    
    static var sharedInstance = Router()
    
    var rootNavigationController : UINavigationController?
    
    func appLaunch(_ window: UIWindow) {
        
        let viewModel = CompaniesListViewModel.init()
        let intialView = CompaniesListViewController.initWithViewModel(viewModel)
        
        rootNavigationController = UINavigationController.init(rootViewController: intialView)
        
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
        
 }


}
