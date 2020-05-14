//
//  VoteViewController.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/14/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class VoteViewController: UIViewController, Storyboarded {

    var presenter: VotePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension VoteViewController: VoteView {
}
