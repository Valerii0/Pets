//
//  QuizViewController.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/14/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController, Storyboarded {

    var presenter: QuizPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension QuizViewController: QuizView {
}
