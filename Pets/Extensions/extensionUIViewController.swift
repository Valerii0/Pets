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
    
//    func errorHandle(error: Error, callBack: @escaping (_ invalidAccessToken: Bool) -> Void) {
//        var errorBody = error.localizedDescription
//        var invalidAccessToken: Bool = false
//        if let errorIndex = Int(error.localizedDescription) {
//            AppConstants.ErrorCode.allValues.forEach({ (errorCode) in
//                if errorCode.rawValue == errorIndex {
//                    errorBody = "\(errorCode) = \(errorIndex)"
//                    invalidAccessToken = errorIndex == AppConstants.ErrorCode.InvalidAccessToken.rawValue ? true : false
//                }
//            })
//        }
//        let alert = UIAlertController(title: "Error", message: errorBody, preferredStyle: .alert)
//        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
//            callBack(invalidAccessToken)
//        })
//        alert.addAction(alertAction)
//        present(alert, animated: true)
//    }
    
    
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
