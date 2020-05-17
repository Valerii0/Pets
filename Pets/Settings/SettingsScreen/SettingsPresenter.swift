//
//  SettingsPresenter.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/14/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

enum SettingsСategories: Int {
    case userData = 0
    case appState = 1
    case info = 2
    
    static let allValues: [SettingsСategories] = [.userData, .appState, .info]
}

enum UserData: Int {
    case liked = 0
    case voted = 1
    case highScore = 2
    
    static let allValues: [UserData] = [.liked, .voted, .highScore]
}

enum AppState: Int {
    case chooseSide = 0
    case logOut = 1
    
    static let allValues: [AppState] = [.chooseSide, .logOut]
}

enum Info: Int {
    case key = 0
    
    static let allValues: [Info] = [.key]
}

protocol SettingsView: class {
}

class SettingsPresenter {
    private weak var view: SettingsView?
    private var coordinator: MainCoordinator?

    init(view: SettingsView, coordinator: MainCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func chooseSide() {
        AccountManager.removeSide()
        coordinator?.configure()
    }
    
    func pushLikedVotedViewController(state: LikedVoted) {
        coordinator?.pushLikedVotedViewController(state: state)
    }
}
