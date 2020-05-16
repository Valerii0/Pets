//
//  SelectionPresenter.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/17/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

protocol SelectionView: class {
}

class SelectionPresenter {
    private weak var view: SelectionView?
    private var coordinator: MainCoordinator?

    init(view: SelectionView, coordinator: MainCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}
