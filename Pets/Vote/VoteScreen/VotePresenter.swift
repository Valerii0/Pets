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
    private var image: Image?
    
    init(view: VoteView, coordinator: MainCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func loadImage() {
        ImagesRequestService.getImages(limit: 1, page: nil, size: ImageSizes.full.rawValue, order: nil, mimeTypes: ImageTypes.jpg.rawValue, categoryIds: nil, breedIds: nil) { (images, error) in
            if let images = images, let image = images.first {
                self.image = image
                self.view?.loadImage(imageUrl: image.url)
            } else if let error = error {
                DispatchQueue.main.async {
                    self.view?.showError(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
    
    func postVote(isLiked: Bool) {
        if let image = image {
            let vote = PostVote(image_id: image.id, value: isLiked, sub_id: AccountManager.UserId())
            VotesRequestService.postVote(vote: vote) { (error) in
                if let error = error {
                    DispatchQueue.main.async {
                        self.view?.showError(title: "Error", message: error.localizedDescription)
                    }
                }
            }
        }
        loadImage()
    }
}
