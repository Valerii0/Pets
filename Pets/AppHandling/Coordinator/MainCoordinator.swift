//
//  MainCoordinator.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/13/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

protocol Coordinatable {
    var tabBarController: UITabBarController { get set }
    var signInRouter: Routable { get set }
    var tabVoteRouter: Routable { get set }
    var tabBreedsRouter: Routable { get set }
    var tabImagesRouter: Routable { get set }
    var tabQuizRouter: Routable { get set }
    var tabSettingsRouter: Routable { get set }
}

final class MainCoordinator: Coordinatable {
    var window: UIWindow
    var tabBarController: UITabBarController
    var signInRouter: Routable
    var tabVoteRouter: Routable
    var tabBreedsRouter: Routable
    var tabImagesRouter: Routable
    var tabQuizRouter: Routable
    var tabSettingsRouter: Routable

    private enum StoryboardsName: String {
        case signIn = "SignIn"
        case tabVote = "Vote"
        case tabBreeds = "Breeds"
        case tabImages = "Images"
        case tabQuiz = "Quiz"
        case tabSettings = "Settings"
        case selection = "Selection"
    }
    
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.tabBarController = UITabBarController()
        self.tabBarController.tabBar.barTintColor = CommonValues.bgColor
        self.tabBarController.tabBar.tintColor = CommonValues.buttonsColor
        self.signInRouter = RouterType.signIn.router
        self.signInRouter.navigationController.navigationBar.isHidden = true
        self.tabVoteRouter = RouterType.tabVote.router
        self.tabVoteRouter.navigationController.navigationBar.backgroundColor = .clear
        self.tabBreedsRouter = RouterType.tabBreeds.router
        self.tabBreedsRouter.navigationController.navigationBar.backgroundColor = .clear
        self.tabImagesRouter = RouterType.tabImages.router
        self.tabImagesRouter.navigationController.navigationBar.backgroundColor = .clear
        self.tabQuizRouter = RouterType.tabQuiz.router
        self.tabQuizRouter.navigationController.navigationBar.backgroundColor = .clear
        self.tabSettingsRouter = RouterType.tabSettings.router
        self.tabSettingsRouter.navigationController.navigationBar.backgroundColor = .clear
    }
    
    func configure() {
        window.rootViewController = UIStoryboard.init(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let state = AccountManager.stateToStart()
            switch state {
            case .login:
                self.makeLogInRoot()
            case .side:
                self.makeChooseYourSideRoot()
            case .app:
                self.makeTabBarRoot()
            }
        }
    }
    
    func makeLogInRoot() {
        window.rootViewController = logInViewController()
    }
    
    func makeChooseYourSideRoot() {
        window.rootViewController = chooseYourSideViewController()
    }
    
    func makeTabBarRoot() {
        window.rootViewController = tabBarController
        tabBarController.viewControllers = [
            voteViewController(),
            breedsViewController(),
            imagesViewController(),
            quizStartViewController(),
            settingsViewController()
        ]
        tabBarController.selectedIndex = 0
    }
    
    
    // SignInRouter
    
    func logInViewController() -> UINavigationController {
        let viewController = LogInViewController.instantiate(storyboardName: StoryboardsName.signIn.rawValue)
        let configurator = LogInConfigurator()
        configurator.configure(viewController: viewController, coordinator: self)
        signInRouter.navigationController.viewControllers = [viewController]
        return signInRouter.navigationController
    }
    
    func pushChooseYourSideViewController() {
        let viewController = ChooseYourSideViewController.instantiate(storyboardName: StoryboardsName.signIn.rawValue)
        let configurator = ChooseYourSideConfigurator()
        configurator.configure(viewController: viewController, coordinator: self)
        signInRouter.push(controller: viewController, animated: true)
    }
    
    func chooseYourSideViewController() -> UINavigationController {
        let viewController = ChooseYourSideViewController.instantiate(storyboardName: StoryboardsName.signIn.rawValue)
        let configurator = ChooseYourSideConfigurator()
        configurator.configure(viewController: viewController, coordinator: self)
        signInRouter.navigationController.viewControllers = [viewController]
        return signInRouter.navigationController
    }
    
    
    // TabVoteRouter
    
    func voteViewController() -> UINavigationController {
        let viewController = VoteViewController.instantiate(storyboardName: StoryboardsName.tabVote.rawValue)
        viewController.tabBarItem = UITabBarItem(title: TabBarTitles.vote.rawValue,
                                                 image: UIImage(named: TabBarImages.vote.rawValue)?.withRenderingMode(.alwaysOriginal),
                                                 selectedImage: UIImage(named: TabBarImages.voteSelected.rawValue)?.withRenderingMode(.alwaysOriginal))
        let configurator = VoteConfigurator()
        configurator.configure(viewController: viewController, coordinator: self)
        tabVoteRouter.navigationController.viewControllers = [viewController]
        return tabVoteRouter.navigationController
    }
    
    
    // TabBreedsRouter
    
    func breedsViewController() -> UINavigationController {
        let viewController = BreedsViewController.instantiate(storyboardName: StoryboardsName.tabBreeds.rawValue)
        viewController.tabBarItem = UITabBarItem(title: TabBarTitles.breeds.rawValue,
                                                 image: UIImage(named: TabBarImages.breeds.rawValue)?.withRenderingMode(.alwaysOriginal),
                                                 selectedImage: UIImage(named: TabBarImages.breedsSelected.rawValue)?.withRenderingMode(.alwaysOriginal))
        let configurator = BreedsConfigurator()
        configurator.configure(viewController: viewController, coordinator: self)
        tabBreedsRouter.navigationController.viewControllers = [viewController]
        return tabBreedsRouter.navigationController
    }
    
    func pushBreedsSelectionViewController(delegate: SelectionPresenterDelegate, dataSource: [String]) {
        let viewController = SelectionViewController.instantiate(storyboardName: StoryboardsName.selection.rawValue)
        let configurator = SelectionConfigurator()
        configurator.configure(viewController: viewController, coordinator: self, delegate: delegate, dataSource: dataSource)
        tabBreedsRouter.push(controller: viewController, animated: true)
    }
    
    func breedsRouterPop() {
        tabBreedsRouter.pop(animated: true)
    }
    
    
    // TabImagesRouter
    
    func imagesViewController() -> UINavigationController {
        let viewController = ImagesViewController.instantiate(storyboardName: StoryboardsName.tabImages.rawValue)
        viewController.tabBarItem = UITabBarItem(title: TabBarTitles.images.rawValue,
                                                 image: UIImage(named: TabBarImages.images.rawValue)?.withRenderingMode(.alwaysOriginal),
                                                 selectedImage: UIImage(named: TabBarImages.imagesSelected.rawValue)?.withRenderingMode(.alwaysOriginal))
        let configurator = ImagesConfigurator()
        configurator.configure(viewController: viewController, coordinator: self)
        tabImagesRouter.navigationController.viewControllers = [viewController]
        return tabImagesRouter.navigationController
    }
    
    func pushLikeViewController(imageId: String, imageUrl: String, state: LikeDelete, delegate: LikeDeletePresenterDelegate?) {
        let viewController = LikeDeleteViewController.instantiate(storyboardName: StoryboardsName.tabSettings.rawValue)
        let configurator = LikeDeleteConfigurator()
        configurator.configure(viewController: viewController, coordinator: self, imageId: imageId, imageUrl: imageUrl, state: state, delegate: delegate)
        tabImagesRouter.push(controller: viewController, animated: true)
    }
    
    func pushImagesFilterSelectionViewController(delegate: SelectionPresenterDelegate, dataSource: [String]) {
        let viewController = SelectionViewController.instantiate(storyboardName: StoryboardsName.selection.rawValue)
        let configurator = SelectionConfigurator()
        configurator.configure(viewController: viewController, coordinator: self, delegate: delegate, dataSource: dataSource)
        tabImagesRouter.push(controller: viewController, animated: true)
    }
    
    func imagesRouterPop() {
        tabImagesRouter.pop(animated: true)
    }
    
    
    // TabQuizRouter
    
    func quizStartViewController() -> UINavigationController {
        let viewController = QuizStartViewController.instantiate(storyboardName: StoryboardsName.tabQuiz.rawValue)
        viewController.tabBarItem = UITabBarItem(title: TabBarTitles.quiz.rawValue,
                                                 image: UIImage(named: TabBarImages.quiz.rawValue)?.withRenderingMode(.alwaysOriginal),
                                                 selectedImage: UIImage(named: TabBarImages.quizSelected.rawValue)?.withRenderingMode(.alwaysOriginal))
        let configurator = QuizStartConfigurator()
        configurator.configure(viewController: viewController, coordinator: self)
        tabQuizRouter.navigationController.viewControllers = [viewController]
        return tabQuizRouter.navigationController
    }
    
    func presentQuizViewController() {
        let viewController = QuizViewController.instantiate(storyboardName: StoryboardsName.tabQuiz.rawValue)
        viewController.modalPresentationStyle = .overFullScreen
        let configurator = QuizConfigurator()
        configurator.configure(viewController: viewController, coordinator: self)
        tabQuizRouter.present(controller: viewController, animated: true)
    }
    
    func quizRouterDismiss() {
        tabQuizRouter.dismiss(animated: true)
    }
    
    
    // TabSettingsRouter
    
    func settingsViewController() -> UINavigationController {
        let viewController = SettingsViewController.instantiate(storyboardName: StoryboardsName.tabSettings.rawValue)
        viewController.tabBarItem = UITabBarItem(title: TabBarTitles.settings.rawValue,
                                                 image: UIImage(named: TabBarImages.settings.rawValue)?.withRenderingMode(.alwaysOriginal),
                                                 selectedImage: UIImage(named: TabBarImages.settingsSelected.rawValue)?.withRenderingMode(.alwaysOriginal))
        let configurator = SettingsConfigurator()
        configurator.configure(viewController: viewController, coordinator: self)
        tabSettingsRouter.navigationController.viewControllers = [viewController]
        return tabSettingsRouter.navigationController
    }
    
    func pushLikedVotedViewController(state: LikedVoted) {
        let viewController = LikedVotedViewController.instantiate(storyboardName: StoryboardsName.tabSettings.rawValue)
        let configurator = LikedVotedConfigurator()
        configurator.configure(viewController: viewController, coordinator: self, state: state)
        tabSettingsRouter.push(controller: viewController, animated: true)
    }
    
    func pushDeleteViewController(imageId: String, imageUrl: String, state: LikeDelete, delegate: LikeDeletePresenterDelegate?) {
        let viewController = LikeDeleteViewController.instantiate(storyboardName: StoryboardsName.tabSettings.rawValue)
        let configurator = LikeDeleteConfigurator()
        configurator.configure(viewController: viewController, coordinator: self, imageId: imageId, imageUrl: imageUrl, state: state, delegate: delegate)
        tabSettingsRouter.push(controller: viewController, animated: true)
    }
    
    func pushVotedYesNoViewController(vote: Vote, delegate: VotedYesNoPresenterDelegate?) {
        let viewController = VotedYesNoViewController.instantiate(storyboardName: StoryboardsName.tabSettings.rawValue)
        let configurator = VotedYesNoConfigurator()
        configurator.configure(viewController: viewController, coordinator: self, vote: vote, delegate: delegate)
        tabSettingsRouter.push(controller: viewController, animated: true)
    }
    
    func pushScoreSelectionViewController(delegate: SelectionPresenterDelegate?, dataSource: [String]) {
        let viewController = SelectionViewController.instantiate(storyboardName: StoryboardsName.selection.rawValue)
        let configurator = SelectionConfigurator()
        configurator.configure(viewController: viewController, coordinator: self, delegate: delegate, dataSource: dataSource)
        tabSettingsRouter.push(controller: viewController, animated: true)
    }
    
    func settingsRouterPop() {
        tabSettingsRouter.pop(animated: true)
    }
}
