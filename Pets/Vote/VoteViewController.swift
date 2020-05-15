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
        presenter.loadImage()
    }
    
    private func setUpUI() {
        view.backgroundColor = CommonValues.bgColor
        
        let logo = UIImage(named: AssetsPathConstants.petsTitle.rawValue)
        let imageView = UIImageView(image: logo)
        //imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        setUpImageView(imageView: petImage)
        setUpButtons()
    }
    
    private func setUpImageView(imageView: UIImageView) {
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = CommonValues.standartCornerRadius
        
//        let shadowLayer = CAShapeLayer()
//        shadowLayer.path = UIBezierPath(roundedRect: imageView.bounds, cornerRadius: CommonValues.standartCornerRadius).cgPath
//        shadowLayer.fillColor = UIColor.clear.cgColor
//        shadowLayer.shadowColor = UIColor.black.cgColor
//        shadowLayer.shadowPath = shadowLayer.path
//        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
//        shadowLayer.shadowOpacity = 0.2
//        shadowLayer.shadowRadius = 3
//        imageView.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    private func setUpButtons() {
        setUpButton(button: dislikeButton, imagePath: "Button Dislike")
        setUpButton(button: likeButton, imagePath: "Button Like (Green heart)")
    }
    
    private func setUpButton(button: UIButton, imagePath: String) {
        button.setTitle(nil, for: .normal)
        button.setImage(UIImage(named: imagePath)?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    @IBAction func dislikeAction(_ sender: UIButton) {
        presenter.postVote(isLiked: false)
    }
    
    @IBAction func likeAction(_ sender: UIButton) {
        presenter.postVote(isLiked: true)
    }
}

extension VoteViewController: VoteView {
    func showError(title: String, message: String) {
        self.showAlert(title: title, message: message)
    }
    
    func loadImage(imageUrl: String) {
        ImageCache.shared.loadImage(imageUrl: imageUrl) { (image, string) in
            DispatchQueue.main.async {
                self.petImage.image = image
            }
        }
    }
}
