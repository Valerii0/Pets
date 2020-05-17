//
//  ImagesPresenter.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/14/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

protocol ImagesView: class {
    func showError(title: String, message: String)
    func reloadData()
}

class ImagesPresenter {
    private weak var view: ImagesView?
    private var coordinator: MainCoordinator?
    private let limit = 20
    private var page = 0
    var images = [Image]()
    
    init(view: ImagesView, coordinator: MainCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func loadImages() {
        ImagesRequestService.getImages(limit: limit, page: page, size: ImageSizes.small.rawValue, order: nil, mimeTypes: ImageTypes.jpg.rawValue, categoryIds: nil, breedIds: nil) { (images, error) in
            if let images = images {
                self.page += 1
                self.images.append(contentsOf: images)
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
    
    func pushLikeViewController(index: Int) {
        coordinator?.pushLikeViewController(imageId: images[index].id, imageUrl: images[index].url, state: .like, delegate: self)
    }
}

extension ImagesPresenter: LikeDeletePresenterDelegate {
    func updateAfterLikeDelete(id: String) {
        DispatchQueue.main.async {
            self.coordinator?.imagesRouterPop()
        }
    }
}
