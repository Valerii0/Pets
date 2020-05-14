//
//  SettingsPresenter.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/14/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

protocol SettingsView: class {
}

class SettingsPresenter {
    private weak var view: SettingsView?
    private var coordinator: MainCoordinator?

    init(view: SettingsView, coordinator: MainCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}
