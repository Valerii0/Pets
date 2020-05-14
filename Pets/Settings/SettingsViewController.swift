//
//  SettingsViewController.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/14/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, Storyboarded {

    var presenter: SettingsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SettingsViewController: SettingsView {
}
