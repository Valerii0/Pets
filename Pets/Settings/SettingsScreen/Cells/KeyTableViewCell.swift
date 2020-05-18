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
        //self.backgroundColor = .clear
        //contentView.backgroundColor = UIColor(red: 54/255.0, green: 19/255.0, blue: 136/255.0, alpha: 1)
        contentView.backgroundColor = CommonValues.bgColor//CommonValues.buttonsColor
        setUpTitleLabel()
        setUpkeyTextView()
    }
    
    private func setUpTitleLabel() {
        titleLabel.contentMode = .left
        titleLabel.textColor = CommonValues.buttonsColor//.white
    }
    
    private func setUpkeyTextView() {
        keyTextView.textColor = CommonValues.buttonsColor
        keyTextView.backgroundColor = .clear
        keyTextView.isEditable = false
        //keyTextView.isSelectable = false
    }
    
    func configure(title: String) {
        titleLabel.text = title
        keyTextView.text = AccountManager.UserId()
        //UIPasteboard.general.string = keyTextView.text
        //.
    }
}
