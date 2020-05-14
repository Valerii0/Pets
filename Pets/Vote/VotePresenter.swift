//
//  VotePresenter.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/14/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

protocol VoteView: class {
}

class VotePresenter {
    private weak var view: VoteView?
    private var coordinator: MainCoordinator?

    init(view: VoteView, coordinator: MainCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}
