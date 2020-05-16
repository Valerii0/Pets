//
//  QuizPresenter.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/14/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

protocol QuizView: class {
}

class QuizPresenter {
    private weak var view: QuizView?
    private var coordinator: MainCoordinator?

    init(view: QuizView, coordinator: MainCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}
