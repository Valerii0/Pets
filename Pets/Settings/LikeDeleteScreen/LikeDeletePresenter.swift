//
//  LikeDeletePresenter.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/17/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

enum LikeDelete {
    case like
    case delete
}

protocol LikeDeleteView: class {
}

protocol LikeDeletePresenterDelegate: class {
    func updateAfterLikeDelete(id: String)
}

class LikeDeletePresenter {
    private weak var view: LikeDeleteView?
    private var coordinator: MainCoordinator?
    private var imageId: String
    private var imageUrl: String
    private var state: LikeDelete
    private weak var delegate: LikeDeletePresenterDelegate?

    init(view: LikeDeleteView, coordinator: MainCoordinator, imageId: String, imageUrl: String, state: LikeDelete, delegate: LikeDeletePresenterDelegate?) {
        self.view = view
        self.coordinator = coordinator
        self.imageId = imageId
        self.imageUrl = imageUrl
        self.state = state
        self.delegate = delegate
    }
    
    func provideState() -> LikeDelete {
        return state
    }
    
    func provideImageUrl() -> String {
        return imageUrl
    }
    
    func performAction() {
        switch state {
        case .like:
            postFavourite()
        case .delete:
            delFavourite()
        }
    }
    
    private func postFavourite() {
        let postFavourite = PostFavourite(image_id: imageId, sub_id: AccountManager.UserId())
        FavouritesRequestService.postFavourite(postFavourite: postFavourite) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
            self.delegate?.updateAfterLikeDelete(id: self.imageId)
        }
    }
    
    private func delFavourite() {
        FavouritesRequestService.delFavourite(favouriteId: imageId) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
            self.delegate?.updateAfterLikeDelete(id: self.imageId)
        }
    }
}
