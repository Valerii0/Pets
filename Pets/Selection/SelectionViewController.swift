//
//  SelectionViewController.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/17/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class SelectionViewController: UIViewController, Storyboarded {

    
    var presenter: SelectionPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension SelectionViewController: SelectionView {
}
