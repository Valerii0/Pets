//
//  QuizViewController.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/14/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController, Storyboarded {
    @IBOutlet weak var progressView: ProgressView!
    @IBOutlet weak var breedImage: UIImageView!
    @IBOutlet weak var firstBreedButton: UIButton!
    @IBOutlet weak var secondBreedButton: UIButton!
    @IBOutlet weak var thirdBreedButton: UIButton!
    @IBOutlet weak var fourthBreedButton: UIButton!
    
    var presenter: QuizPresenter!
    
    private var timer: Timer?
    private var timeLeft: Int = 3
    private var totalPoints: Int = 0
    private var wordIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        presenter.getBreeds()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        progressView.progressAnimation(duration: TimeInterval(self.timeLeft))
//    }
    
    private func setUpUI() {
        coloredBg()
        addLogoToNavigation()
        setUpPetImageView(imageView: breedImage)
        setUpButtons()
        setUpTimer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//        //progressView.layoutIfNeeded()
            self.progressView.progressAnimation(duration: TimeInterval(self.timeLeft))
        }
    }
    
    private func setUpButtons() {
        setUpButton(button: firstBreedButton)
        setUpButton(button: secondBreedButton)
        setUpButton(button: thirdBreedButton)
        setUpButton(button: fourthBreedButton)
    }
    
    private func setUpButton(button: UIButton) {
        button.setTitle(nil, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = CommonValues.buttonsColor
        button.layer.cornerRadius = CommonValues.standardCornerRadius
    }
    
    private func setUpTimer() {
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
    }
    
    @objc func onTimerFires() {
        timeLeft -= 1
        //timerLabel.text = "\(timeLeft)"
        if timeLeft <= 0 {
            timer?.invalidate()
            timer = nil
            self.showAlertWithOkAction(title: "Done!", message: "Your score: \(totalPoints)") { (finished) in
                self.presenter.finish()
            }
        }
    }
    
    @IBAction func firstAction(_ sender: UIButton) {
    }
    
    @IBAction func secondAction(_ sender: UIButton) {
    }
    
    @IBAction func thirdAction(_ sender: UIButton) {
    }
    
    @IBAction func fourthAction(_ sender: UIButton) {
    }
}

extension QuizViewController: QuizView {
    func showError(title: String, message: String) {
        self.showAlert(title: title, message: message)
    }
    
    func loadImage(url: String) {
        loadImage(imageUrl: url, imageView: breedImage)
    }
    
    func loadTitles(title1: String, title2: String, title3: String, title4: String) {
        DispatchQueue.main.async {
            self.firstBreedButton.setTitle(title1, for: .normal)
            self.secondBreedButton.setTitle(title2, for: .normal)
            self.thirdBreedButton.setTitle(title3, for: .normal)
            self.fourthBreedButton.setTitle(title4, for: .normal)
        }
    }
}
