//
//  QuizStartViewController.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/16/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class QuizStartViewController: UIViewController, Storyboarded {
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    
    var presenter: QuizStartPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        coloredBg()
        addLogoToNavigation()
        titleImage.image = UIImage(named: "Guess The Breed")?.withRenderingMode(.alwaysTemplate)
        titleImage.contentMode = .scaleAspectFit
        titleImage.tintColor = CommonValues.buttonsColor
        
        setUpButton(button: startButton, title: "Let's go!")
    }
    
    private func setUpButton(button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = CommonValues.buttonsColor
        button.layer.cornerRadius = CommonValues.standartCornerRadius
    }
    
    @IBAction func startAction(_ sender: UIButton) {
        presenter.presentQuizViewController()
    }
}

extension QuizStartViewController: QuizStartView {
}
