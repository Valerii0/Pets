//
//  VoteViewController.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/14/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class VoteViewController: UIViewController, Storyboarded {
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    var presenter: VotePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        presenter.loadImages()
    }
    
    private func setUpUI() {
        coloredBg()
        addLogoToNavigation()
        setUpPetImageView(imageView: petImage)
        setUpButtons()
    }
    
    private func setUpButtons() {
        setUpButton(button: dislikeButton, imagePath: AssetsPathConstants.buttonDislike.rawValue)
        setUpButton(button: likeButton, imagePath: AssetsPathConstants.buttonLikeGreen.rawValue)
    }
    
    private func setUpButton(button: UIButton, imagePath: String) {
        button.setTitle(nil, for: .normal)
        button.setImage(UIImage(named: imagePath)?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    @IBAction func dislikeAction(_ sender: UIButton) {
        presenter.actionPressed(isLiked: false)
    }
    
    @IBAction func likeAction(_ sender: UIButton) {
        presenter.actionPressed(isLiked: true)
    }
}

extension VoteViewController: VoteView {
    func showError(title: String, message: String) {
        self.showAlert(title: title, message: message)
    }
    
    func loadImage(imageUrl: String) {
        ImageCache.shared.loadImage(imageUrl: imageUrl) { (image, string) in
            DispatchQueue.main.async {
                self.petImage.image == nil ? self.petImage.image = image :
                    UIView.transition(with: self.petImage, duration: 0.5, options: .transitionCurlUp, animations: {
                        self.petImage.image = image
                    })
            }
        }
    }
}
