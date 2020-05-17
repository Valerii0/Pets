//
//  LikeDeleteViewController.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/17/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class LikeDeleteViewController: UIViewController, Storyboarded {
    @IBOutlet weak var petImage: UIImageView!
    
    @IBOutlet weak var likeDeleteButton: UIButton!
    var presenter: LikeDeletePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func likeDeleteButton(_ sender: UIButton) {
    }
}

extension LikeDeleteViewController: LikeDeleteView {
    
}
