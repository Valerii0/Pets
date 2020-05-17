//
//  Configurator.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/13/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

protocol LogInConfigurable {
    func configure(viewController: LogInViewController, coordinator: MainCoordinator)
}

class LogInConfigurator: LogInConfigurable {
    func configure(viewController: LogInViewController, coordinator: MainCoordinator) {
        let logInPresenter = LogInPresenter(view: viewController, coordinator: coordinator)
        viewController.presenter = logInPresenter
    }
}

protocol ChooseYourSideConfigurable {
    func configure(viewController: ChooseYourSideViewController, coordinator: MainCoordinator)
}

class ChooseYourSideConfigurator: ChooseYourSideConfigurable {
    func configure(viewController: ChooseYourSideViewController, coordinator: MainCoordinator) {
        let chooseYourSidePresenter = ChooseYourSidePresenter(view: viewController, coordinator: coordinator)
        viewController.presenter = chooseYourSidePresenter
    }
}

protocol VoteConfigurable {
    func configure(viewController: VoteViewController, coordinator: MainCoordinator)
}

class VoteConfigurator: VoteConfigurable {
    func configure(viewController: VoteViewController, coordinator: MainCoordinator) {
        let votePresenter = VotePresenter(view: viewController, coordinator: coordinator)
        viewController.presenter = votePresenter
    }
}

protocol BreedsConfigurable {
    func configure(viewController: BreedsViewController, coordinator: MainCoordinator)
}

class BreedsConfigurator: BreedsConfigurable {
    func configure(viewController: BreedsViewController, coordinator: MainCoordinator) {
        let breedsPresenter = BreedsPresenter(view: viewController, coordinator: coordinator)
        viewController.presenter = breedsPresenter
    }
}

protocol ImagesConfigurable {
    func configure(viewController: ImagesViewController, coordinator: MainCoordinator)
}

class ImagesConfigurator: ImagesConfigurable {
    func configure(viewController: ImagesViewController, coordinator: MainCoordinator) {
        let imagesPresenter = ImagesPresenter(view: viewController, coordinator: coordinator)
        viewController.presenter = imagesPresenter
    }
}

protocol QuizStartConfigurable {
    func configure(viewController: QuizStartViewController, coordinator: MainCoordinator)
}

class QuizStartConfigurator: QuizStartConfigurable {
    func configure(viewController: QuizStartViewController, coordinator: MainCoordinator) {
        let quizStartPresenter = QuizStartPresenter(view: viewController, coordinator: coordinator)
        viewController.presenter = quizStartPresenter
    }
}

protocol QuizConfigurable {
    func configure(viewController: QuizViewController, coordinator: MainCoordinator)
}

class QuizConfigurator: QuizConfigurable {
    func configure(viewController: QuizViewController, coordinator: MainCoordinator) {
        let quizPresenter = QuizPresenter(view: viewController, coordinator: coordinator)
        viewController.presenter = quizPresenter
    }
}

protocol SettingsConfigurable {
    func configure(viewController: SettingsViewController, coordinator: MainCoordinator)
}

class SettingsConfigurator: SettingsConfigurable {
    func configure(viewController: SettingsViewController, coordinator: MainCoordinator) {
        let settingsPresenter = SettingsPresenter(view: viewController, coordinator: coordinator)
        viewController.presenter = settingsPresenter
    }
}

protocol LikedVotedConfigurable {
    func configure(viewController: LikedVotedViewController, coordinator: MainCoordinator,
                   state: LikedVoted)
}

class LikedVotedConfigurator: LikedVotedConfigurable {
    func configure(viewController: LikedVotedViewController, coordinator: MainCoordinator,
                   state: LikedVoted) {
        let likedVotedPresenter = LikedVotedPresenter(view: viewController, coordinator: coordinator, state: state)
        viewController.presenter = likedVotedPresenter
    }
}

protocol LikeDeleteConfigurable {
    func configure(viewController: LikeDeleteViewController, coordinator: MainCoordinator,
                   imageId: String, imageUrl: String, state: LikeDelete, delegate: LikeDeletePresenterDelegate?)
}

class LikeDeleteConfigurator: LikeDeleteConfigurable {
    func configure(viewController: LikeDeleteViewController, coordinator: MainCoordinator,
                   imageId: String, imageUrl: String, state: LikeDelete, delegate: LikeDeletePresenterDelegate?) {
        let likeDeletePresenter = LikeDeletePresenter(view: viewController, coordinator: coordinator, imageId: imageId, imageUrl: imageUrl, state: state, delegate: delegate)
        viewController.presenter = likeDeletePresenter
    }
}

protocol VotedYesNoConfigurable {
    func configure(viewController: VotedYesNoViewController, coordinator: MainCoordinator,
                   image: Image, state: VotedYesNo)
}

class VotedYesNoConfigurator: VotedYesNoConfigurable {
    func configure(viewController: VotedYesNoViewController, coordinator: MainCoordinator,
                   image: Image, state: VotedYesNo) {
        let votedYesNoPresenter = VotedYesNoPresenter(view: viewController, coordinator: coordinator, image: image, state: state)
        viewController.presenter = votedYesNoPresenter
    }
}

protocol SelectionConfigurable {
    func configure(viewController: SelectionViewController, coordinator: MainCoordinator,
                   delegate: SelectionPresenterDelegate, dataSource: [String])
}

class SelectionConfigurator: SelectionConfigurable {
    func configure(viewController: SelectionViewController, coordinator: MainCoordinator,
                   delegate: SelectionPresenterDelegate, dataSource: [String]) {
        let selectionPresenter = SelectionPresenter(view: viewController, coordinator: coordinator,
                                                    delegate: delegate, dataSource: dataSource)
        viewController.presenter = selectionPresenter
    }
}
