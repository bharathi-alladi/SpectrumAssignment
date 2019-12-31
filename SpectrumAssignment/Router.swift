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
    
    func navigateToCompanyDetails (_ company : Company) {
        
        let viewModel = CompanyDetailViewModel.init(company)
        
        let detailedView = CompanyDetailController.initWithViewModel(viewModel)
        detailedView.tabBarItem = UITabBarItem.init(title: "Company Details", image: nil, tag: 0)
        
        let memberListView = MemberListController.initWithViewModel(viewModel)
        memberListView.tabBarItem = UITabBarItem.init(title: "Company Members", image: nil, tag: 1)
        
        let tabbarViewController = UITabBarController.init()
        tabbarViewController.title = company.company
        tabbarViewController.setViewControllers([detailedView, memberListView], animated: true)
        rootNavigationController?.pushViewController(tabbarViewController, animated: true)
    }


}
