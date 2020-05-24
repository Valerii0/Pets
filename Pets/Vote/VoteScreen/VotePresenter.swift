//
//  VotePresenter.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/14/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

protocol VoteView: class {
    func showError(title: String, message: String)
    func loadImage(imageUrl: String)
}

class VotePresenter {
    private weak var view: VoteView?
    private var coordinator: MainCoordinator?
    private let maxLimit = VoteConstants.maxLimit
    private let minLimit = VoteConstants.minLimit
    private var images = [Image]()
    private var firstLoad: Bool = true
    
    init(view: VoteView, coordinator: MainCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func loadImages() {
        ImagesRequestService.getImages(limit: maxLimit, page: nil, size: ImageSizes.full.rawValue, order: nil, mimeTypes: ImageTypes.jpg.rawValue, categoryIds: nil, breedIds: nil) { (images, error) in
            if let images = images, images.count > 0 {
                self.images.append(contentsOf: images)
                self.preLoadImages(images: images)
                self.checkFirstLoad()
            } else if let error = error {
                DispatchQueue.main.async {
                    self.view?.showError(title: CommonValues.errorTitle, message: error.localizedDescription)
                }
            }
        }
    }
    
    private func preLoadImages(images: [Image]) {
        images.forEach({ image in
            ImageCache.shared.loadImage(imageUrl: image.url) { (image, url) in
                print(url)
            }
        })
    }
    
    private func checkFirstLoad() {
        if firstLoad {
            firstLoad = false
            view?.loadImage(imageUrl: images.first?.url ?? "")
        }
    }
    
    func actionPressed(isLiked: Bool) {
        if let image = images.first {
            postVote(isLiked: isLiked, image: image)
            images.removeFirst()
        }
        view?.loadImage(imageUrl: images.first?.url ?? "")
        loadMoreIfNeeded()
    }
    
    private func postVote(isLiked: Bool, image: Image) {
        let vote = PostVote(image_id: image.id, value: isLiked, sub_id: AccountManager.UserId())
        VotesRequestService.postVote(vote: vote) { (error) in
            if let error = error {
                DispatchQueue.main.async {
                    self.view?.showError(title: CommonValues.errorTitle, message: error.localizedDescription)
                }
            }
        }
    }
    
    private func loadMoreIfNeeded() {
        if images.count <= minLimit {
            loadImages()
        }
    }
}
