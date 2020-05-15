//
//  LogInViewController.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/13/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, Storyboarded {
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    
    var presenter: LogInPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        view.backgroundColor = UIColor(red: 255/255.0, green: 251/255.0, blue: 247/255.0, alpha: 1)
        logoImage.image = UIImage(named: AssetsPathConstants.pets.rawValue)
        logoImage.contentMode = .scaleAspectFit
        
        setUpButtons()
        setUpTextField(textField: idTextField)
        hideKeyboardWhenTappedAround()
    }
    
    private func setUpButtons() {
        setUpButton(button: generateButton, title: LogInConstants.generate.rawValue)
        setUpButton(button: logInButton, title: LogInConstants.logIn.rawValue)
    }
    
    private func setUpButton(button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 255/255.0, green: 149/255.0, blue: 0/255.0, alpha: 1)
        button.layer.cornerRadius = CommonValues.standartCornerRadius
    }
    
    private func setUpTextField(textField: UITextField) {
        textField.backgroundColor = .clear
        textField.textColor = .gray
        textField.borderStyle = .none
        textField.autocapitalizationType = .none
        textField.returnKeyType = .done
        textField.placeholder = LogInConstants.userId.rawValue
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 1, width: textField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        textField.layer.addSublayer(bottomLine)
    }
    
    @IBAction func genarateAction(_ sender: UIButton) {
        let uuid = UUID().uuidString
        idTextField.text = uuid
    }
    
    @IBAction func logInAction(_ sender: UIButton) {
        if let text = idTextField.text, text.count > 4 {
            presenter.logIn(id: text)
        }
    }
}

extension LogInViewController: LogInView {
}
