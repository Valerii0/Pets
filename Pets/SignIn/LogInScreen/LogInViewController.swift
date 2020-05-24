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
        coloredBg()
        setUpImage()
        setUpButtons()
        setUpTextField(textField: idTextField)
        hideKeyboardWhenTappedAround()
    }
    
    private func setUpImage() {
        logoImage.image = UIImage(named: AssetsPathConstants.petsLogo.rawValue)
        logoImage.contentMode = .scaleAspectFit
    }
    
    private func setUpButtons() {
        setUpButton(button: generateButton, title: LogInConstants.generate.rawValue)
        setUpButton(button: logInButton, title: LogInConstants.logIn.rawValue)
    }
    
    private func setUpButton(button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = CommonValues.buttonsColor
        button.layer.cornerRadius = CommonValues.standardCornerRadius
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
        
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.delegate = self
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        checkForMaxLength(textField: textField)
    }
    
    private func checkForMaxLength(textField: UITextField) {
        guard let text = textField.text else { return }
        if text.count > LogInConstants.maxUserIdLength {
            textField.deleteBackward()
        }
    }
    
    private func generateUserId() {
        var uuid = UUID().uuidString
        if uuid.count > LogInConstants.maxUserIdLength {
            uuid = String(uuid.prefix(LogInConstants.maxUserIdLength))
        }
        idTextField.text = uuid
    }
    
    private func checkUserIdForLogIn() {
        guard let text = idTextField.text else { return }
        if text.count >= LogInConstants.minUserIdLength && text.count <= LogInConstants.maxUserIdLength {
            presenter.logIn(id: text)
        } else {
            self.showAlert(title: CommonValues.errorTitle, message: "\(LogInConstants.errFirstPart) \(LogInConstants.minUserIdLength) \(LogInConstants.errSecondPart) \(LogInConstants.maxUserIdLength) \(LogInConstants.errThirdPart)")
        }
    }
    
    @IBAction func genarateAction(_ sender: UIButton) {
        generateUserId()
    }
    
    @IBAction func logInAction(_ sender: UIButton) {
        checkUserIdForLogIn()
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        checkUserIdForLogIn()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let whitespaceSet = CharacterSet.whitespaces
        if let _ = string.rangeOfCharacter(from: whitespaceSet) {
            return false
        }
        return true
    }
}

extension LogInViewController: LogInView {
}
