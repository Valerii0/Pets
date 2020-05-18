//
//  QuizPresenter.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/14/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

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

    init(view: QuizView, coordinator: MainCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    private func postFavourite() {
        let randomIndex = Int(arc4random_uniform(UInt32(99)))
        let postFavourite = PostFavourite(image_id: "\(randomIndex)", sub_id: AccountManager.UserScoreId())
        ScoreRequestService.postScore(postScore: postFavourite) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
            //            ScoreRequestService.getScores() { (favourites, error) in
            //                print(favourites)
            //            }
        }
    }
    
    func getBreeds() {
        BreedsRequestService.getBreeds(limit: nil, page: nil) { (breeds, error) in
            if let breeds = breeds {
                self.breeds = breeds
                self.checkBreedsCount()
            } else if let error = error {
                DispatchQueue.main.async {
                    self.view?.showError(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
    
    private func loadImages(breedId: String) {
        ImagesRequestService.getImages(limit: 1, page: nil, size: ImageSizes.full.rawValue, order: nil, mimeTypes: ImageTypes.jpg.rawValue, categoryIds: nil, breedIds: breedId) { (images, error) in
            if let images = images {
                self.view?.loadImage(url: images.first?.url ?? "default")
            } else if let error = error {
                DispatchQueue.main.async {
                    self.view?.showError(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
    
    private func checkBreedsCount() {
        if breeds.count < 4 {
            finish()
        } else {
            configure()
        }
    }
    
    private func configure() {
        random4Breeds.removeAll()
        randomBreed = nil
        create4RandomBreeds()
        pickOneFrom4RandomBreeds()
        loadImages(breedId: randomBreed!.id)
        view?.loadTitles(title1: random4Breeds[0].name, title2: random4Breeds[1].name, title3: random4Breeds[2].name, title4: random4Breeds[3].name)
    }
    
    private func create4RandomBreeds() {
        while random4Breeds.count < 4 {
            let randomIndex = Int(arc4random_uniform(UInt32(breeds.count - 1)))
            if !random4Breeds.contains(where: { $0.id == breeds[randomIndex].id }) {
                random4Breeds.append(breeds[randomIndex])
            }
        }
    }
    
    private func pickOneFrom4RandomBreeds() {
        let randomIndex = Int(arc4random_uniform(UInt32(random4Breeds.count)))
        randomBreed = random4Breeds[randomIndex]
    }
    
    func finish() {
        postFavourite()
        //coordinator?.quizRouterDismiss()
    }
}
