//
//  MembersViewCell.swift
//  SpectrumAssignment
//
//  Created by Chandrika Alladi on 6/1/20.
//  Copyright © 2020 Alladi Satya Chandra Bharathi. All rights reserved.
//

import UIKit

class MembersViewCell: UITableViewCell {

    @IBOutlet var nameLbl:UILabel!
    @IBOutlet var ageLbl:UILabel!
    @IBOutlet var favouriteBtn:UIButton!
    
    var member:Member!
    var bindingViewModel:ListViewModel!
    
    func configUI(member: Member, viewModel:ListViewModel) {
        
        self.member = member
        self.bindingViewModel = viewModel
        
        self.nameLbl.text = member.fullName()
        self.ageLbl.text = STRING_CONSTANTS.AGE + ": " + String(member.age)
        
        if member.isFavourite == true {
            favouriteBtn.setImage(UIImage.init(named: ASSET_CONSTANTS.FAV_BTN_SELECTED), for: .normal)
        } else {
            favouriteBtn.setImage(UIImage.init(named: ASSET_CONSTANTS.FAV_BTN), for: .normal)
        }
    }
    
    @IBAction func favouriteBtnAction() {
        
        if self.member.isFavourite == true {
            self.member.isFavourite = false
            favouriteBtn.setImage(UIImage.init(named: ASSET_CONSTANTS.FAV_BTN), for: .normal)
        } else {
            self.member.isFavourite = true
            favouriteBtn.setImage(UIImage.init(named: ASSET_CONSTANTS.FAV_BTN_SELECTED), for: .normal)
        }
        
        bindingViewModel.memberUpdated(for: self.member)
    }
}
