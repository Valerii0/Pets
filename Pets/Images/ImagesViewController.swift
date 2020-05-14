//
//  ImagesViewController.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/14/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController, Storyboarded {

    var presenter: ImagesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ImagesViewController: ImagesView {
}
