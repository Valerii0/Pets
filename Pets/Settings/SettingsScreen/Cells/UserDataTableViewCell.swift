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
        //self.backgroundColor = .clear
        contentView.backgroundColor = CommonValues.bgColor//CommonValues.buttonsColor//UIColor(red: 54/255.0, green: 19/255.0, blue: 136/255.0, alpha: 1)
        setUpTitleLabel()
        setUpNextImage()
    }
    
    private func setUpTitleLabel() {
        titleLabel.contentMode = .left
        titleLabel.textColor = CommonValues.buttonsColor//.white
    }
    
    private func setUpNextImage() {
        nextImage.image = UIImage(named: "Arrow Light")
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
