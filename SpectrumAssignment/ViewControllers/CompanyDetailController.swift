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
    
    @IBOutlet var companyimage : UIImageView!
    @IBOutlet var aboutLabel : UILabel!
    @IBOutlet var websiteLabel : UILabel!
    
    
    class func initWithViewModel(_ viewModel: CompanyDetailViewModel) -> CompanyDetailController {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vcObj = storyBoard.instantiateViewController(withIdentifier: "CompanyDetailController") as! CompanyDetailController
        vcObj.viewModel = viewModel
        vcObj.viewModel.companyDetailController = vcObj
        return vcObj
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadUI()
        self.companyimage.layer.borderWidth = 1
        self.companyimage.layer.masksToBounds = false
        self.companyimage.layer.borderColor = UIColor.black.cgColor
        self.companyimage.layer.cornerRadius = companyimage.frame.height/2
        self.companyimage.clipsToBounds = true
    }
    
    // load UI
    func loadUI() {
        
        let details = viewModel.getDetails()
//        companyimage.image =
        aboutLabel.text = details.about
        websiteLabel.text = details.website
        
    }

}
