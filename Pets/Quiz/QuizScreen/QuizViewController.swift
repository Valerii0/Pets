//
//  QuizViewController.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/14/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController, Storyboarded {
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: ProgressView!
    @IBOutlet weak var breedImage: UIImageView!
    @IBOutlet weak var firstBreedButton: UIButton!
    @IBOutlet weak var secondBreedButton: UIButton!
    @IBOutlet weak var thirdBreedButton: UIButton!
    @IBOutlet weak var fourthBreedButton: UIButton!
    
    var presenter: QuizPresenter!
    
    private var timer: Timer?
    private var timeLeft: Int = QuizConstants.timeLeft
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        presenter.getBreeds()
        configure()
    }
    
    private func setUpUI() {
        coloredBg()
        setUpPetImageView(imageView: breedImage)
        setUpLabel(label: progressLabel, title: "\(timeLeft)")
        setUpButtons()
    }
    
    private func configure() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.setUpTimer()
            self.progressView.progressAnimation(duration: TimeInterval(self.timeLeft))
        }
    }
    
    private func setUpLabel(label: UILabel, title: String) {
        label.textColor = CommonValues.buttonsColor
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.text = title
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
        progressLabel.text = "\(timeLeft)"
        if timeLeft <= 0 {
            timer?.invalidate()
            timer = nil
            showAlertWithOkAction(title: QuizConstants.alertTitle.rawValue, message: "\(QuizConstants.alertMessage.rawValue) \(presenter.finalScore)") { (finished) in
                self.presenter.finish()
            }
        }
    }
    
    @IBAction func firstAction(_ sender: UIButton) {
        presenter.pressButton(pressButton: .first)
    }
    
    @IBAction func secondAction(_ sender: UIButton) {
        presenter.pressButton(pressButton: .second)
    }
    
    @IBAction func thirdAction(_ sender: UIButton) {
        presenter.pressButton(pressButton: .third)
    }
    
    @IBAction func fourthAction(_ sender: UIButton) {
        presenter.pressButton(pressButton: .fourth)
    }
}

extension QuizViewController: QuizView {
    func showError(title: String, message: String) {
        self.showAlert(title: title, message: message)
    }
    
    func loadImage(url: String) {
        ImageCache.shared.loadImage(imageUrl: url) { (image, string) in
            DispatchQueue.main.async {
                self.breedImage.image == nil ? self.breedImage.image = image :
                    UIView.transition(with: self.breedImage, duration: 1.0, options: .transitionFlipFromLeft, animations: {
                        self.breedImage.image = image
                    })
            }
        }
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
