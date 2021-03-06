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
    func reloadImages()
    func loadBreedInfo(breed: Breed)
}

class BreedsPresenter {
    private weak var view: BreedsView?
    private var coordinator: MainCoordinator?
    private let limit = BreedsConstants.imagesLimit
    private var breeds = [Breed]()
    private var images = [Image]()
    var imagesToShow: [Image] {
        return images
    }

    init(view: BreedsView, coordinator: MainCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func getBreeds() {
        BreedsRequestService.getBreeds(limit: nil, page: nil) { (breeds, error) in
            if let breeds = breeds, breeds.count > 0 {
                self.breeds = breeds
                self.selectBreedByIndex(index: 0)
            } else if let error = error {
                DispatchQueue.main.async {
                    self.view?.showError(title: CommonValues.errorTitle, message: error.localizedDescription)
                }
            }
        }
    }
    
    private func loadImages(breedId: String) {
        ImagesRequestService.getImages(limit: limit, page: nil, size: ImageSizes.full.rawValue, order: nil, mimeTypes: nil, categoryIds: nil, breedIds: breedId) { (images, error) in
            if let images = images {
                self.images = images
                DispatchQueue.main.async {
                    self.view?.reloadImages()
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    self.view?.showError(title: CommonValues.errorTitle, message: error.localizedDescription)
                }
            }
        }
    }
    
    func pushBreedsSelectionViewController() {
        if breeds.count > 0 {
            coordinator?.pushBreedsSelectionViewController(delegate: self, dataSource: dataSourceForSelection())
        }
    }
    
    private func selectBreedByIndex(index: Int) {
        if breeds.count > index {
            loadImages(breedId: breeds[index].id)
            DispatchQueue.main.async {
                self.view?.loadBreedInfo(breed: self.breeds[index])
            }
        }
    }
    
    private func dataSourceForSelection() -> [String] {
        var dataSource = [String]()
        breeds.forEach { (breed) in
            dataSource.append(breed.name)
        }
        return dataSource
    }
}

extension BreedsPresenter: SelectionPresenterDelegate {
    func changeIndex(index: Int) {
        DispatchQueue.main.async {
            self.coordinator?.breedsRouterPop()
        }
        selectBreedByIndex(index: index)
    }
}
