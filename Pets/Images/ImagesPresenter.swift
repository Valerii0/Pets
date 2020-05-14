//
//  ImagesPresenter.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/14/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

protocol ImagesView: class {
}

class ImagesPresenter {
    private weak var view: ImagesView?
    private var coordinator: MainCoordinator?

    init(view: ImagesView, coordinator: MainCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}
