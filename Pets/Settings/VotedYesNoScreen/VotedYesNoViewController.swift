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
    @IBOutlet weak var deleteButton: UIButton!
    
    var presenter: VotedYesNoPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        presenter.getSpecificImage()
    }
    
    private func setUpUI() {
        coloredBg()
        addLogoToNavigation()
        setUpNavigationBarItemsColor()
        setUpPetImageView(imageView: petImage)
        setUpStateView()
        setUpButton(button: deleteButton, imagePath: AssetsPathConstants.buttonDelete.rawValue)
        animateShow()
    }
    
    private func setUpStateView() {
        stateView.layer.cornerRadius = CommonValues.standardCornerRadius
        stateView.backgroundColor = .clear
    }
    
    private func setUpButton(button: UIButton, imagePath: String) {
        button.setTitle(nil, for: .normal)
        button.setImage(UIImage(named: imagePath)?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    private func animateShow() {
        UIView.animate(withDuration: 1.0, animations: {
            self.configureStateView()
            self.configureStateImage()
        })
    }
    
    private func configureStateView() {
        switch presenter.provideState() {
        case .yes:
            self.stateView.backgroundColor = CommonValues.standardGreen
        case .no:
            self.stateView.backgroundColor = CommonValues.standardRed
        }
    }
    
    private func configureStateImage() {
        switch presenter.provideState() {
        case .yes:
            self.stateImage.image = UIImage(named: AssetsPathConstants.likedTitle.rawValue)
        case .no:
            self.stateImage.image = UIImage(named: AssetsPathConstants.dislikedTitle.rawValue)
        }
    }
    
    private func configureDeleted() {
        stateView.backgroundColor = CommonValues.standardBlue
        stateImage.image = UIImage(named: AssetsPathConstants.deletedTitle.rawValue)
    }
    
    @IBAction func deleteAction(_ sender: UIButton) {
        UIView.animate(withDuration: 1.0, animations: {
            self.configureDeleted()
        }) { (finished) in
            self.presenter.delVote()
        }
    }
}

extension VotedYesNoViewController: VotedYesNoView {
    func loadImage(image: Image) {
        loadImage(imageUrl: image.url, imageView: petImage)
    }
}
