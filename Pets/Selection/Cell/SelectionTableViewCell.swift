//
//  SelectionTableViewCell.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/17/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class SelectionTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    private func setUpUI() {
        //self.backgroundColor = .clear
        //contentView.backgroundColor = UIColor(red: 54/255.0, green: 19/255.0, blue: 136/255.0, alpha: 1)
        contentView.backgroundColor = CommonValues.bgColor//CommonValues.buttonsColor
        setUpTitleLabel()
    }
    
    private func setUpTitleLabel() {
        titleLabel.contentMode = .left
        titleLabel.textColor = CommonValues.buttonsColor//.white
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
