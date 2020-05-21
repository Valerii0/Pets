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
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
    func showAlertWithOkAction(title: String, message: String, callBack: @escaping (_ finished: Bool) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            callBack(true)
        })
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
    func showAlertWithOkCancelAction(title: String, message: String, callBack: @escaping (_ finished: Bool) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            callBack(true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true, completion: nil)
    }
    
    func coloredBg() {
        view.backgroundColor = CommonValues.bgColor
    }
    
    func addLogoToNavigation() {
        let logo = UIImage(named: AssetsPathConstants.petsTitle.rawValue)
        let imageView = UIImageView(image: logo)
        //imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
//        imageView.contentMode = .ScaleAspectFit
//        let image = UIImage(named: "YOURIMAGE")
//        imageView.image = image
//        navigationItem.titleView = imageView
    }
    
    func setUpPetImageView(imageView: UIImageView) {
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = CommonValues.standardCornerRadius
        
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
    
    func loadImage(imageUrl: String, imageView: UIImageView) {
        ImageCache.shared.loadImage(imageUrl: imageUrl) { (image, string) in
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
    }
    
    func setUpNavigationBarItemsColor() {
        self.navigationController?.navigationBar.tintColor = CommonValues.buttonsColor
        //        let yourBackImage = UIImage(named: "Button Delete")
        //        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        //        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        //self.navigationController?.navigationBar.backItem?.title = "Custom"
    }
    
    
    
    
    
//    func startLoadingScreen() -> UIImageView {
//        let loadingImage = UIImage(named: AppConstants.AssetsConstants.loading)
//        let loadingImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
//        loadingImageView.image = loadingImage
//        loadingImageView.contentMode = .scaleToFill
//        self.view.addSubview(loadingImageView)
//        return loadingImageView
//    }
//
//    func stopLoadingScreen(viewForRemove: UIImageView) {
//        viewForRemove.removeFromSuperview()
//    }
    
    func startLoadingView() -> UIView {
        let loadingView = UIView(frame: UIScreen.main.bounds)
        loadingView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        self.view.addSubview(loadingView)
        let spinner = UIActivityIndicatorView(style: .large)
        loadingView.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true
        return loadingView
    }

    func stopLoadingView(viewForRemove: UIView) {
        viewForRemove.removeFromSuperview()
    }
}
