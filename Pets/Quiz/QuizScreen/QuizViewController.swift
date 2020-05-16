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
    private var timeLeft: Int = 60
    private var totalPoints: Int = 0
    private var wordIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        coloredBg()
        addLogoToNavigation()
        setUpButtons()
        setUpTimer()
        //DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        progressView.layoutIfNeeded()
            self.progressView.progressAnimation(duration: TimeInterval(self.timeLeft))
        //}
        
        
    }
    
    private func setUpButtons() {
        setUpButton(button: firstBreedButton, title: ImagesConstants.order.rawValue)
        setUpButton(button: secondBreedButton, title: ImagesConstants.type.rawValue)
        setUpButton(button: thirdBreedButton, title: ImagesConstants.category.rawValue)
        setUpButton(button: fourthBreedButton, title: ImagesConstants.breed.rawValue)
    }
    
    private func setUpButton(button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = CommonValues.buttonsColor
        button.layer.cornerRadius = CommonValues.standartCornerRadius
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
            self.showAlert(title: "Done!", message: "Your score: \(totalPoints)")
            //presenter.postSubmit(vocabularySprintWordsPoints: vocabularySprintWordsPoints)
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
}
