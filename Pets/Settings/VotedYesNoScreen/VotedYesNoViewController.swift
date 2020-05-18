//
//  VotedYesNoViewController.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/17/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class VotedYesNoViewController: UIViewController, Storyboarded {
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var stateView: UIView!
    @IBOutlet weak var stateImage: UIImageView!
    
    var presenter: VotedYesNoPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
//        coloredBg()
//        addLogoToNavigation()
//        customBackButton()
//        setUpPetImageView(imageView: petImage)
//        loadImage(imageUrl: presenter.provideImageUrl(), imageView: petImage)
//        setUpStateView()
//        setUpButtonByState()
    }
}

extension VotedYesNoViewController: VotedYesNoView {
    
}
