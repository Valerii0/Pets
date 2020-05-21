//
//  ImagesPresenter.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/14/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

enum ImagesFilters {
    case category
    case breed
}

protocol ImagesView: class {
    func showError(title: String, message: String)
    func reloadData()
    func changeCategory(category: String)
    func changeBreed(breed: String)
}

class ImagesPresenter {
    private weak var view: ImagesView?
    private var coordinator: MainCoordinator?
    private var imagesFilter: ImagesFilters = .category
    private let limit = 20
    private var page = 0
    private var isImagesExist: Bool = true
    private var images = [Image]()
    private var categories = [Category]()
    private var categoryId: Int?
    private var breeds = [Breed]()
    private var breedId: String?
    var imagesToShow: [Image] {
        return images
    }
    var canLoad: Bool {
        return isImagesExist
    }
    
    init(view: ImagesView, coordinator: MainCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func getCategories() {
        CategoriesRequestService.getCategories { (categories, error) in
            if let categories = categories {
                self.categories = categories
            } else if let error = error {
                DispatchQueue.main.async {
                    self.view?.showError(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
    
    func getBreeds() {
        BreedsRequestService.getBreeds(limit: nil, page: nil) { (breeds, error) in
            if let breeds = breeds {
                self.breeds = breeds
            } else if let error = error {
                DispatchQueue.main.async {
                    self.view?.showError(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
    
    func loadImages() {
        ImagesRequestService.getImages(limit: limit, page: page, size: ImageSizes.small.rawValue, order: nil, mimeTypes: ImageTypes.jpg.rawValue, categoryIds: categoryId, breedIds: breedId) { (images, error) in
            if let images = images, images.count > 0, !self.images.contains(where: { $0.id == images.first?.id }) {
                self.page += 1
                self.images.append(contentsOf: images)
                DispatchQueue.main.async {
                    self.view?.reloadData()
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    self.view?.showError(title: "Error", message: error.localizedDescription)
                }
            } else {
                self.isImagesExist = false
            }
        }
    }
    
    func pushLikeViewController(index: Int) {
        coordinator?.pushLikeViewController(imageId: images[index].id, imageUrl: images[index].url, state: .like, delegate: self)
    }
    
    func pushImagesFilterSelectionViewController(filter: ImagesFilters) {
        self.imagesFilter = filter
        coordinator?.pushImagesFilterSelectionViewController(delegate: self, dataSource: createDataSource())
    }
    
    private func createDataSource() -> [String] {
        var dataSource = [String]()
        switch imagesFilter {
        case .category:
            categories.forEach { (category) in
                dataSource.append(category.name)
            }
        case .breed:
            breeds.forEach { (breed) in
                dataSource.append(breed.name)
            }
        }
        return dataSource
    }
    
    func clearFilters() {
        changeCategoryFilter(index: nil)
        changeBreedFilter(index: nil)
        updateAfterFilterChanged()
    }
    
    private func changeFilter(index: Int) {
        switch imagesFilter {
        case .category:
            changeCategoryFilter(index: index)
        case .breed:
            changeBreedFilter(index: index)
        }
    }
    
    private func changeCategoryFilter(index: Int?) {
        if let index = index, categories.count > index {
            view?.changeCategory(category: categories[index].name)
            categoryId = categories[index].id
        } else {
            view?.changeCategory(category: ImagesConstants.defaultFill.rawValue)
            categoryId = nil
        }
    }
    
    private func changeBreedFilter(index: Int?) {
        if let index = index, breeds.count > index {
            view?.changeBreed(breed: breeds[index].name)
            breedId = breeds[index].id
        } else {
            view?.changeBreed(breed: ImagesConstants.defaultFill.rawValue)
            breedId = nil
        }
    }
    
    private func updateAfterFilterChanged() {
        images.removeAll()
        view?.reloadData()
        isImagesExist = true
        page = 0
        loadImages()
    }
}

extension ImagesPresenter: LikeDeletePresenterDelegate {
    func updateAfterLikeDelete(id: String) {
        DispatchQueue.main.async {
            self.coordinator?.imagesRouterPop()
        }
    }
}

extension ImagesPresenter: SelectionPresenterDelegate {
    func changeIndex(index: Int) {
        DispatchQueue.main.async {
            self.coordinator?.imagesRouterPop()
            self.changeFilter(index: index)
            self.updateAfterFilterChanged()
        }
    }
}
