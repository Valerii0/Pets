//
//  LogInViewController.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/13/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, Storyboarded {

    var presenter: LogInPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension LogInViewController: LogInView {
}
