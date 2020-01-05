//
//  MemberDetailsControllerViewController.swift
//  SpectrumAssignment
//
//  Created by Chandrika Alladi on 1/1/20.
//  Copyright © 2020 Alladi Satya Chandra Bharathi. All rights reserved.
//

import UIKit

class MemberDetailsController: UIViewController {
    
   
    @IBOutlet var memberNameText : UILabel!
    @IBOutlet var memberAgeText : UILabel!
    @IBOutlet var memberEmailText : UILabel!
    @IBOutlet var memberPhoneText : UILabel!
    
    var viewModel : MemberDetailViewModel!
    
    class func initWithViewModel(_ viewModel: MemberDetailViewModel) -> MemberDetailsController {
        
        let storyBoard = UIStoryboard.init(name: STRING_CONSTANTS.MAIN, bundle: nil)
        let vcObj = storyBoard.instantiateViewController(withIdentifier: VIEW_CONTROLLER_CONSTANTS.MEMBER_DETAIL) as! MemberDetailsController
        vcObj.viewModel = viewModel
        vcObj.viewModel.viewController = vcObj
        return vcObj
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.loadUI()
    }
    
    func loadUI() {
        
        let memberObj = viewModel.getMemberDetails()
        memberAgeText.text = String(memberObj.age)
        memberEmailText.text = memberObj.email
        memberPhoneText.text = memberObj.phone
        
        memberNameText.text = memberObj.fullName()
    }
}
