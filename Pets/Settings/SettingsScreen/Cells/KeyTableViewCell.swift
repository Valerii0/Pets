//
//  KeyTableViewCell.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/15/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class KeyTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var keyTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    private func setUpUI() {
        contentView.backgroundColor = CommonValues.bgColor
        setUpTitleLabel()
        setUpkeyTextView()
    }
    
    private func setUpTitleLabel() {
        titleLabel.contentMode = .left
        titleLabel.textColor = CommonValues.buttonsColor
    }
    
    private func setUpkeyTextView() {
        keyTextView.textColor = CommonValues.buttonsColor
        keyTextView.backgroundColor = .clear
        keyTextView.isEditable = false
    }
    
    func configure(title: String) {
        titleLabel.text = title
        keyTextView.text = AccountManager.UserId()
    }
}
