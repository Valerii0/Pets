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
    private var votes = [Vote]()
    private var favourites = [Favourite]()
    private var isImagesExist: Bool = true
    private var sortType: ComparisonResult = .orderedAscending

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
    
    func imagesCount() -> Int {
        switch state {
        case .liked:
            return favourites.count
        case .voted:
            return votes.count
        }
    }
    
    func imageUrl(index: Int) -> String {
        switch state {
        case .liked:
            return favourites[index].image.url
        case .voted:
            return "\(AccountManager.imagesUrl())\(votes[index].image_id).jpg"
        }
    }
    
    func imagePressed(index: Int) {
        switch state {
        case .liked:
            pushDeleteViewController(index: index)
        case .voted:
            pushVotedYesNoViewController(index: index)
        }
    }
    
    func canLoad() -> Bool {
        return isImagesExist
    }
    
    func sort() {
        sortType = sortType == .orderedAscending ? .orderedDescending : .orderedAscending
        switch state {
        case .liked:
            favourites.sort(by: {$0.created_at.localizedStandardCompare($1.created_at) == sortType})
        case .voted:
            votes.sort(by: {$0.created_at.localizedStandardCompare($1.created_at) == sortType})
        }
        view?.reloadData()
    }
    
    private func getFavourites() {
        FavouritesRequestService.getFavourites(limit: limit, page: page, order: "", size: "") { (favourites, error) in
            if let favourites = favourites, favourites.count > 0 {
                self.page += 1
                self.favourites.append(contentsOf: favourites)
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
    
    private func getVotes() {
        VotesRequestService.getVotes(limit: limit, page: page) { (votes, error) in
            if let votes = votes, votes.count > 0 {
                self.page += 1
                self.votes.append(contentsOf: votes)
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
    
    private func pushDeleteViewController(index: Int) {
        coordinator?.pushDeleteViewController(imageId: String(favourites[index].id), imageUrl: favourites[index].image.url, state: .delete, delegate: self)
    }
    
    private func pushVotedYesNoViewController(index: Int) {
        coordinator?.pushVotedYesNoViewController(vote: votes[index], delegate: self)
    }
    
    private func closeAndUpdate(id: String) {
        coordinator?.settingsRouterPop()
        removeDeletedElement(id: id)
        view?.reloadData()
    }
    
    private func removeDeletedElement(id: String) {
        switch state {
        case .liked:
            favourites.removeAll(where: { String($0.id) == id })
        case .voted:
            votes.removeAll(where: { String($0.id) == id })
        }
    }
}

extension LikedVotedPresenter: LikeDeletePresenterDelegate {
    func updateAfterLikeDelete(id: String) {
        DispatchQueue.main.async {
            self.closeAndUpdate(id: id)
        }
    }
}

extension LikedVotedPresenter: VotedYesNoPresenterDelegate {
    func updateAfterVoteDelete(id: String) {
        DispatchQueue.main.async {
            self.closeAndUpdate(id: id)
        }
    }
}
