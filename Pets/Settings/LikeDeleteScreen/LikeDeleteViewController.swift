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
    @IBOutlet weak var stateView: UIView!
    @IBOutlet weak var stateImage: UIImageView!
    @IBOutlet weak var likeDeleteButton: UIButton!
    
    var presenter: LikeDeletePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        coloredBg()
        addLogoToNavigation()
        setUpNavigationBarItemsColor()
        setUpPetImageView(imageView: petImage)
        loadImage(imageUrl: presenter.provideImageUrl(), imageView: petImage)
        setUpStateView()
        setUpButtonByState()
    }
    
    private func setUpStateView() {
        stateView.layer.cornerRadius = CommonValues.standardCornerRadius
        stateView.backgroundColor = .clear
    }
    
    private func setUpButtonByState() {
        switch presenter.provideState() {
        case .like:
            setUpButton(button: likeDeleteButton, imagePath: "Button Like (Red heart)")
        case .delete:
            setUpButton(button: likeDeleteButton, imagePath: "Button Delete")
        }
    }
    
    private func setUpButton(button: UIButton, imagePath: String) {
        button.setTitle(nil, for: .normal)
        button.setImage(UIImage(named: imagePath)?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    private func setUpStateImageByState() {
        switch presenter.provideState() {
        case .like:
            self.stateImage.image = UIImage(named: "Liked")
        case .delete:
            self.stateImage.image = UIImage(named: "Deleted")
        }
    }
    
    private func setUpstateViewByState() {
        switch presenter.provideState() {
        case .like:
            self.stateView.backgroundColor = CommonValues.standardRed
        case .delete:
            self.stateView.backgroundColor = CommonValues.standardBlue
        }
    }
    
    @IBAction func likeDeleteButton(_ sender: UIButton) {
        setUpStateImageByState()
        
        UIView.animate(withDuration: 1.0, animations: {
            self.setUpstateViewByState()
        }) { (finished) in
            self.presenter.performAction()
        }
    }
}

extension LikeDeleteViewController: LikeDeleteView {
}
