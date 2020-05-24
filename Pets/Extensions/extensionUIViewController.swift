//
//  extensionUIViewController.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/15/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    ///hide keyboard on tap
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(UIViewController.dismissKeyboard))
        ///???????????
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    ///custom alert
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: CommonValues.okTitle, style: .default)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
    func showAlertWithOkAction(title: String, message: String, callBack: @escaping (_ finished: Bool) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: CommonValues.okTitle, style: .default, handler: { (action: UIAlertAction!) in
            callBack(true)
        })
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
    func showAlertWithOkCancelAction(title: String, message: String, callBack: @escaping (_ finished: Bool) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: CommonValues.okTitle, style: .default, handler: { (action: UIAlertAction!) in
            callBack(true)
        }))
        alert.addAction(UIAlertAction(title: CommonValues.cancelTitle, style: .cancel))
        present(alert, animated: true, completion: nil)
    }
    
    func coloredBg() {
        view.backgroundColor = CommonValues.bgColor
    }
    
    func addLogoToNavigation() {
        let logo = UIImage(named: AssetsPathConstants.petsTitle.rawValue)
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
    }
    
    func setUpPetImageView(imageView: UIImageView) {
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = CommonValues.standardCornerRadius
    }
    
    func loadImage(imageUrl: String, imageView: UIImageView) {
        ImageCache.shared.loadImage(imageUrl: imageUrl) { (image, string) in
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
    }
    
    func setUpNavigationBarItemsColor() {
        self.navigationController?.navigationBar.tintColor = CommonValues.buttonsColor
    }
}
