//
//  QuizStartPresenter.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/16/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

protocol QuizStartView: class {
}

class QuizStartPresenter {
    private weak var view: QuizStartView?
    private var coordinator: MainCoordinator?

    init(view: QuizStartView, coordinator: MainCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func presentQuizViewController() {
        coordinator?.presentQuizViewController()
    }
}
