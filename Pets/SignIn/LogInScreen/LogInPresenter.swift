//
//  LogInPresenter.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/14/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

protocol LogInView: class {
}

class LogInPresenter {
    private weak var view: LogInView?
    private var coordinator: MainCoordinator?

    init(view: LogInView, coordinator: MainCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func logIn(id: String) {
        AccountManager.setLoginId(id: id)
        coordinator?.pushChooseYourSideViewController()
    }
}
