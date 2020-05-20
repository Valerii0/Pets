//
//  ImagesPresenter.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/14/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

enum ImagesFilters {
    case order
    case type
    case category
    case breed
}

protocol ImagesView: class {
    func showError(title: String, message: String)
    func reloadData()
    func breedBu(breed: String)
    func categoriesDD(category: String)
}

class ImagesPresenter {
    private weak var view: ImagesView?
    private var coordinator: MainCoordinator?
    private var imagesFilter: ImagesFilters = .order
    private var breeds = [Breed]()
    private var breedId: String?
    private let limit = 20
    private var page = 0
    private var isImagesExist: Bool = true
    var images = [Image]()
    private var categories = [Category]()
    private var categoryId: Int?
    
    init(view: ImagesView, coordinator: MainCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func canLoad() -> Bool {
        return isImagesExist
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
                self.isImagesExist = false  ////problem of max 20 pic
            }
        }
    }
    
    func pushLikeViewController(index: Int) {
        coordinator?.pushLikeViewController(imageId: images[index].id, imageUrl: images[index].url, state: .like, delegate: self)
    }
    
    func pushImagesFilterSelectionViewController(filter: ImagesFilters) {
        imagesFilter = filter
        
        var dataSource = [String]()
        
        switch imagesFilter {
        case .order:
            print("order")
        case .type:
            print("type")
        case .category:
            dataSource = categoriesDataSource()
        case .breed:
            dataSource = breedsDataSource()
        }
        coordinator?.pushImagesFilterSelectionViewController(delegate: self, dataSource: dataSource)
    }
    
    private func breedsDataSource() -> [String] {
        var dataSource = [String]()
        breeds.forEach { (breed) in
            dataSource.append(breed.name)
        }
        return dataSource
    }
    
    private func categoriesDataSource() -> [String] {
        var dataSource = [String]()
        categories.forEach { (category) in
            dataSource.append(category.name)
        }
        return dataSource
    }
    
    private func updateAfterFilterChanged() {
        page = 0
        images.removeAll()
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
            switch self.imagesFilter {
            case .order:
                print("order")
            case .type:
                print("type")
            case .category:
                self.view?.categoriesDD(category: self.categories[index].name)
                self.categoryId = self.categories[index].id
            case .breed:
                self.view?.breedBu(breed: self.breeds[index].name)
                self.breedId = self.breeds[index].id
            }
            self.updateAfterFilterChanged()
        }
        
    }
}
