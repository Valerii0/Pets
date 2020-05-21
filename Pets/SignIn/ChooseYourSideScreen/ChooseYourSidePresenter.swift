//
//  ChooseYourSidePresenter.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/14/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

protocol ChooseYourSideView: class {
}

class ChooseYourSidePresenter {
    private weak var view: ChooseYourSideView?
    private var coordinator: MainCoordinator?

    init(view: ChooseYourSideView, coordinator: MainCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func chooseSide(side: String) {
        AccountManager.setSide(side: side)
        coordinator?.configure()
    }
}
