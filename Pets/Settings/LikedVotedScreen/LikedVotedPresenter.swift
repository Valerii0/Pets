//
//  LikedVotedPresenter.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/17/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

enum LikedVoted {
    case liked
    case voted
}

protocol LikedVotedView: class {
    func showError(title: String, message: String)
    func reloadData()
}

class LikedVotedPresenter {
    private weak var view: LikedVotedView?
    private var coordinator: MainCoordinator?
    private var state: LikedVoted
    private let limit = 20
    private var page = 0
    var votes = [Vote]()
    var favourites = [Favourite]()

    init(view: LikedVotedView, coordinator: MainCoordinator, state: LikedVoted) {
        self.view = view
        self.coordinator = coordinator
        self.state = state
    }
    
    func loadImages() {
        switch state {
        case .liked:
            getFavourites()
        case .voted:
            getVotes()
        }
    }
    
    private func getFavourites() {
        FavouritesRequestService.getFavourites(limit: limit, page: page, order: "", size: "") { (favourites, error) in
            if let favourites = favourites {
                self.page += 1
                self.favourites.append(contentsOf: favourites)
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
    
    private func getVotes() {
        VotesRequestService.getVotes(limit: limit, page: page) { (votes, error) in
            if let votes = votes {
                self.page += 1
                self.votes.append(contentsOf: votes)
                
//                VotesRequestService.getSpecificVote(voteId: votes[0].id) { (Error) in
//                    print(error?.localizedDescription)
//                }
                
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
    
    func pushDeleteViewController(index: Int) {
        coordinator?.pushDeleteViewController(imageId: String(favourites[index].id), imageUrl: favourites[index].image.url, state: .delete, delegate: self)
    }
    
    private func removeDeletedElement(id: String) {
        favourites.removeAll(where: { String($0.id) == id })
    }
}

extension LikedVotedPresenter: LikeDeletePresenterDelegate {
    func updateAfterLikeDelete(id: String) {
        DispatchQueue.main.async {
            self.coordinator?.settingsRouterPop()
            self.removeDeletedElement(id: id)
            self.view?.reloadData()
        }
    }
}
