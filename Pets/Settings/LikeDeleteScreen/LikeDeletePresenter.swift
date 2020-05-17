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
//    func showError(title: String, message: String)
//    func reloadData()
}

class LikeDeletePresenter {
    private weak var view: LikeDeleteView?
    private var coordinator: MainCoordinator?
    private let limit = 20
    private var page = 0
    var votes = [Vote]()
    var favourites = [Favourite]()

    init(view: LikeDeleteView, coordinator: MainCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
//    func getVotes() {
//        VotesRequestService.getVotes(limit: limit, page: page) { (votes, error) in
//            if let votes = votes {
//                self.page += 1
//                self.votes.append(contentsOf: votes)
//                DispatchQueue.main.async {
//                    self.view?.reloadData()
//                }
//            } else if let error = error {
//                DispatchQueue.main.async {
//                    self.view?.showError(title: "Error", message: error.localizedDescription)
//                }
//            }
//        }
//    }
//
//    func getFavourites() {
//        FavouritesRequestService.getFavourites(limit: limit, page: page, order: "", size: "") { (favourites, error) in
//            if let favourites = favourites {
//                self.page += 1
//                self.favourites.append(contentsOf: favourites)
//                DispatchQueue.main.async {
//                    self.view?.reloadData()
//                }
//            } else if let error = error {
//                DispatchQueue.main.async {
//                    self.view?.showError(title: "Error", message: error.localizedDescription)
//                }
//            }
//        }
//    }
}
