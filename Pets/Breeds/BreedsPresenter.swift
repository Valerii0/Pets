//
//  BreedsPresenter.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/14/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

protocol BreedsView: class {
}

class BreedsPresenter {
    private weak var view: BreedsView?
    private var coordinator: MainCoordinator?

    init(view: BreedsView, coordinator: MainCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}
