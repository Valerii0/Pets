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
    private var scores = [Favourite]()

    init(view: SettingsView, coordinator: MainCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func chooseSide() {
        AccountManager.removeSide()
        coordinator?.configure()
    }
    
    func logOut() {
        AccountManager.removeLoginId()
        coordinator?.configure()
    }
    
    func pushLikedVotedViewController(state: LikedVoted) {
        coordinator?.pushLikedVotedViewController(state: state)
    }
    
    func pushScoreSelectionViewController() {
        coordinator?.pushScoreSelectionViewController(delegate: nil, dataSource: dataSourceForSelection())
    }
    
    func updateScore() {
        ScoreRequestService.getScores { (scores, error) in
            if let scores = scores {
                self.scores = scores
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func dataSourceForSelection() -> [String] {
        var dataSource = [String]()
        let sortedScores = scores.sorted(by: {$0.image_id.localizedStandardCompare($1.image_id) == .orderedDescending})
        sortedScores.forEach { (score) in
            let scoreText = "\(score.image_id) points. \(score.created_at.stringDate(dateFormatFrom: SettingsConstants.dateFormatFrom.rawValue, dateFormatTo: SettingsConstants.dateFormatTo.rawValue))"
            dataSource.append(scoreText)
        }
        return dataSource
    }
}
