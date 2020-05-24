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
        contentView.backgroundColor = CommonValues.bgColor
        setUpTitleLabel()
    }
    
    private func setUpTitleLabel() {
        titleLabel.contentMode = .left
        titleLabel.textColor = CommonValues.buttonsColor
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
