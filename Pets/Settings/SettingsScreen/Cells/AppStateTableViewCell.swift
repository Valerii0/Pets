//
//  AppStateTableViewCell.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/15/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class AppStateTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    private func setUpUI() {
        //self.backgroundColor = .clear
        //contentView.backgroundColor = UIColor(red: 54/255.0, green: 19/255.0, blue: 136/255.0, alpha: 1)
        setUpTitleLabel()
    }
    
    private func setUpTitleLabel() {
        titleLabel.contentMode = .left
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
