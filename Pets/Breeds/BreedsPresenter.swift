//
//  BreedsPresenter.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/14/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

protocol BreedsView: class {
    func showError(title: String, message: String)
    func reloadData()
    func reloadImages()
}

class BreedsPresenter {
    private weak var view: BreedsView?
    private var coordinator: MainCoordinator?
    private let limit = 5
    var breeds = [Breed]()
    var images = [Image]()

    init(view: BreedsView, coordinator: MainCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func getBreeds() {
        BreedsRequestService.getBreeds(limit: nil, page: nil) { (breeds, error) in
            if let breeds = breeds {
                self.breeds = breeds
                DispatchQueue.main.async {
                    self.view?.reloadData()
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    self.view?.showError(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
    
    func loadImages() {
        ImagesRequestService.getImages(limit: limit, page: nil, size: ImageSizes.full.rawValue, order: nil, mimeTypes: ImageTypes.png.rawValue, categoryIds: nil, breedIds: nil) { (images, error) in
            if let images = images {
                self.images = images
                DispatchQueue.main.async {
                    self.view?.reloadImages()
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    self.view?.showError(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
}
