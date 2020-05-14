//
//  ChooseYourSideViewController.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/13/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class ChooseYourSideViewController: UIViewController, Storyboarded {

    var presenter: ChooseYourSidePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ChooseYourSideViewController: ChooseYourSideView {
}
