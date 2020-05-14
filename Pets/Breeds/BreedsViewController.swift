//
//  BreedsViewController.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/14/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class BreedsViewController: UIViewController, Storyboarded {

    var presenter: BreedsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BreedsViewController: BreedsView {
}
