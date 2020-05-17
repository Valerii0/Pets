//
//  VotedYesNoPresenter.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/17/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

enum VotedYesNo {
    case yes
    case no
}

protocol VotedYesNoView: class {
//    func showError(title: String, message: String)
//    func reloadData()
}

class VotedYesNoPresenter {
    private weak var view: VotedYesNoView?
    private var coordinator: MainCoordinator?
    private var image: Image
    private var state: VotedYesNo

    init(view: VotedYesNoView, coordinator: MainCoordinator, image: Image, state: VotedYesNo) {
        self.view = view
        self.coordinator = coordinator
        self.image = image
        self.state = state
    }
}
