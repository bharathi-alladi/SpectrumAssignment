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
        
        let viewModel = ListViewModel.init()
        let companiesView = CompaniesListViewController.initWithViewModel(viewModel)
        companiesView.tabBarItem = UITabBarItem.init(title: STRING_CONSTANTS.COMPANIES, image: UIImage.init(named: ASSET_CONSTANTS.COMPANY_ICON), tag: 0)
        
        let memberView = MembersViewController.initWithViewModel(viewModel)
        memberView.tabBarItem = UITabBarItem.init(title: STRING_CONSTANTS.COMPANY_MEMBERS, image: UIImage.init(named: ASSET_CONSTANTS.MEMBERS_ICON), tag: 1)
        
        let tabBarController = UITabBarController.init()
        tabBarController.setViewControllers([companiesView, memberView], animated: true)
        rootNavigationController = UINavigationController.init(rootViewController: tabBarController)
        
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
        window.tintColor = UIColor.init(named: ASSET_CONSTANTS.APP_COLOR)
    }
    
    func navigateToCompanyDetails (_ company : Company) {
        
        let viewModel = CompanyDetailViewModel.init(company)
        let detailedView = CompanyDetailController.initWithViewModel(viewModel)
        rootNavigationController?.pushViewController(detailedView, animated: true)
    }
    
    func navigateToMemberDetails (_member : Member) {
        
        let viewModel = MemberDetailViewModel.init(_member)
        let memberView = MemberDetailsController.initWithViewModel(viewModel)
        rootNavigationController?.pushViewController(memberView, animated: true)
    }


}
