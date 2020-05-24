//
//  QuizPresenter.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/14/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

enum PressButtons: Int {
    case first = 0
    case second = 1
    case third = 2
    case fourth = 3
    
    static let allValues: [PressButtons] = [.first, .second, .third, .fourth]
}

protocol QuizView: class {
    func showError(title: String, message: String)
    func loadImage(url: String)
    func loadTitles(title1: String, title2: String, title3: String, title4: String)
}

class QuizPresenter {
    private weak var view: QuizView?
    private var coordinator: MainCoordinator?
    private var breeds = [Breed]()
    private var random4Breeds = [Breed]()
    private var randomBreed: Breed?
    private var totalPoints: Int = 0
    var finalScore: Int {
        return totalPoints
    }

    init(view: QuizView, coordinator: MainCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func getBreeds() {
        BreedsRequestService.getBreeds(limit: nil, page: nil) { (breeds, error) in
            if let breeds = breeds {
                self.breeds = breeds
                self.checkBreedsCount()
            } else if let error = error {
                DispatchQueue.main.async {
                    self.view?.showError(title: CommonValues.errorTitle, message: error.localizedDescription)
                }
            }
        }
    }
    
    private func loadImage(breedId: String) {
        ImagesRequestService.getImages(limit: 1, page: nil, size: ImageSizes.full.rawValue, order: nil, mimeTypes: ImageTypes.jpg.rawValue, categoryIds: nil, breedIds: breedId) { (images, error) in
            if let images = images, let image = images.first {
                self.view?.loadImage(url: image.url)
            } else if let error = error {
                DispatchQueue.main.async {
                    self.view?.showError(title: CommonValues.errorTitle, message: error.localizedDescription)
                }
            }
        }
    }
    
    private func saveScore(score: String) {
        let postScore = PostFavourite(image_id: score, sub_id: AccountManager.UserScoreId())
        ScoreRequestService.postScore(postScore: postScore) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func checkBreedsCount() {
        if breeds.count < PressButtons.allValues.count {
            finish()
        } else {
            configureQuiz()
        }
    }
    
    private func configureQuiz() {
        random4Breeds.removeAll()
        randomBreed = nil
        create4RandomBreeds()
        pickOneFrom4RandomBreeds()
        if let breedId = randomBreed?.id {
            loadImage(breedId: breedId)
        }
        view?.loadTitles(title1: random4Breeds[PressButtons.first.rawValue].name,
                         title2: random4Breeds[PressButtons.second.rawValue].name,
                         title3: random4Breeds[PressButtons.third.rawValue].name,
                         title4: random4Breeds[PressButtons.fourth.rawValue].name)
    }
    
    private func create4RandomBreeds() {
        while random4Breeds.count < PressButtons.allValues.count {
            let randomIndex = Int.random(in: 0..<breeds.count)
            if !random4Breeds.contains(where: { $0.id == breeds[randomIndex].id }) {
                random4Breeds.append(breeds[randomIndex])
            }
        }
    }
    
    private func pickOneFrom4RandomBreeds() {
        let randomIndex = Int.random(in: 0..<random4Breeds.count)
        randomBreed = random4Breeds[randomIndex]
    }
    
    func pressButton(pressButton: PressButtons) {
        if random4Breeds[pressButton.rawValue].id == randomBreed?.id {
            totalPoints += 1
        }
        configureQuiz()
    }
    
    func finish() {
        if totalPoints > 0 {
            saveScore(score: "\(totalPoints)")
        }
        coordinator?.quizRouterDismiss()
    }
}
