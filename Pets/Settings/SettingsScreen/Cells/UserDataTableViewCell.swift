//
//  UserDataTableViewCell.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/15/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class UserDataTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nextImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    private func setUpUI() {
        contentView.backgroundColor = CommonValues.bgColor
        setUpTitleLabel()
        setUpNextImage()
    }
    
    private func setUpTitleLabel() {
        titleLabel.contentMode = .left
        titleLabel.textColor = CommonValues.buttonsColor
    }
    
    private func setUpNextImage() {
        nextImage.image = UIImage(named: AssetsPathConstants.arrow.rawValue)
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
