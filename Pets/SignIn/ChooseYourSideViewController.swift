//
//  ChooseYourSideViewController.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/13/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class ChooseYourSideViewController: UIViewController, Storyboarded {
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var dogButton: UIButton!
    @IBOutlet weak var catButton: UIButton!
    
    var presenter: ChooseYourSidePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        view.backgroundColor = UIColor(red: 255/255.0, green: 251/255.0, blue: 247/255.0, alpha: 1)
        logoImage.image = UIImage(named: AssetsPathConstants.pets.rawValue)
        logoImage.contentMode = .scaleAspectFit
        titleImage.image = UIImage(named: AssetsPathConstants.chooseYourSide.rawValue)
        titleImage.contentMode = .scaleAspectFit
        
        setUpButtons()
    }
    
    private func setUpButtons() {
        setUpButton(button: dogButton, imagePath: AssetsPathConstants.dog.rawValue)
        setUpButton(button: catButton, imagePath: AssetsPathConstants.cat.rawValue)
    }
    
    private func setUpButton(button: UIButton, imagePath: String) {
        button.setTitle(nil, for: .normal)
        button.setImage(UIImage(named: imagePath)?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    @IBAction func dogAction(_ sender: UIButton) {
        presenter.chooseSide(side: Side.dog.rawValue)
    }
    
    @IBAction func catAction(_ sender: UIButton) {
        presenter.chooseSide(side: Side.cat.rawValue)
    }
}

extension ChooseYourSideViewController: ChooseYourSideView {
}
