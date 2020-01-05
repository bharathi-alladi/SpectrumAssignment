//
//  CompanyTableVIewCellTableViewCell.swift
//  SpectrumAssignment
//
//  Created by Chandrika Alladi on 31/12/19.
//  Copyright © 2019 Alladi Satya Chandra Bharathi. All rights reserved.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {

    @IBOutlet var companiesIcons : UIImageView!
    @IBOutlet var companynameLable : UILabel!
    
    @IBOutlet var favouriteButton: UIButton!
    @IBOutlet var followButton:UIButton!
    
    var _company:Company!
    var bindingViewModel:ListViewModel!
    
    func configUI(company: Company, viewModel:ListViewModel) {
        self._company = company
        self.bindingViewModel = viewModel
        self.companiesIcons.image(urlString: company.logo, withPlaceHolder: UIImage.init(named: ASSET_CONSTANTS.PLACEHOLDER_PIC), doOverwrite: false)
        self.companiesIcons.layer.borderWidth = 1
        self.companiesIcons.layer.masksToBounds = false
        self.companiesIcons.layer.borderColor = UIColor.init(named: ASSET_CONSTANTS.APP_COLOR)!.cgColor
        self.companiesIcons.layer.cornerRadius = self.companiesIcons.frame.height/2
        self.companiesIcons.clipsToBounds = true
        
        self.companynameLable.text = company.company
        
        if company.isFavourite == true {
            favouriteButton.setImage(UIImage.init(named: ASSET_CONSTANTS.FAV_BTN_SELECTED), for: .normal)
        } else {
            favouriteButton.setImage(UIImage.init(named: ASSET_CONSTANTS.FAV_BTN), for: .normal)
        }
        
        if company.isFollowing == true {
            followButton.setTitle(STRING_CONSTANTS.FOLLOWING, for: .normal)
        } else {
            followButton.setTitle(STRING_CONSTANTS.FOLLOW, for: .normal)
        }
    }
    
    @IBAction func favouriteBtnAction() {
        
        if self._company.isFavourite == true {
            self._company.isFavourite = false
            favouriteButton.setImage(UIImage.init(named: ASSET_CONSTANTS.FAV_BTN), for: .normal)
        } else {
            self._company.isFavourite = true
            favouriteButton.setImage(UIImage.init(named: ASSET_CONSTANTS.FAV_BTN_SELECTED), for: .normal)
        }
        
        bindingViewModel.companyUpdated(for: self._company)
    }
    
    @IBAction func followBtnAction() {
        
        if _company.isFollowing == true {
            self._company.isFollowing = false
            followButton.setTitle(STRING_CONSTANTS.FOLLOW, for: .normal)
        } else {
            self._company.isFollowing = true
            followButton.setTitle(STRING_CONSTANTS.FOLLOWING, for: .normal)
        }
        
        bindingViewModel.companyUpdated(for: self._company)
    }
}
