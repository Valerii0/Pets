//
//  VotedYesNoPresenter.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/17/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

enum VotedYesNo: Int {
    case no = 0
    case yes = 1
}

protocol VotedYesNoView: class {
    func loadImage(image: Image)
}

protocol VotedYesNoPresenterDelegate: class {
    func updateAfterVoteDelete(id: String)
}

class VotedYesNoPresenter {
    private weak var view: VotedYesNoView?
    private var coordinator: MainCoordinator?
    private var vote: Vote
    private weak var delegate: VotedYesNoPresenterDelegate?

    init(view: VotedYesNoView, coordinator: MainCoordinator, vote: Vote, delegate: VotedYesNoPresenterDelegate?) {
        self.view = view
        self.coordinator = coordinator
        self.vote = vote
        self.delegate = delegate
    }
    
    func provideState() -> VotedYesNo {
        guard let voteState = VotedYesNo(rawValue: vote.value) else { return .no }
        return voteState
    }
    
    func getSpecificImage() {
        ImagesRequestService.getSpecificImage(imageId: vote.image_id) { (image, error) in
            if let image = image {
                self.view?.loadImage(image: image)
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func delVote() {
        VotesRequestService.delVote(voteId: vote.id) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
            self.delegate?.updateAfterVoteDelete(id: String(self.vote.id))
        }
    }
}
