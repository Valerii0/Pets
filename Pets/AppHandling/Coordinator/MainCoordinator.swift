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
    }
    
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.tabBarController = UITabBarController()
        self.tabBarController.tabBar.barTintColor = UIColor(red: 12/255.0, green: 19/255.0, blue: 55/255.0, alpha: 1)
        self.tabBarController.tabBar.tintColor = .white
        self.signInRouter = RouterType.signIn.router
        
        self.tabVoteRouter = RouterType.tabVote.router
        self.tabVoteRouter.navigationController.navigationBar.isHidden = true
        
        self.tabBreedsRouter = RouterType.tabBreeds.router
        self.tabBreedsRouter.navigationController.navigationBar.isHidden = true
        
        self.tabImagesRouter = RouterType.tabImages.router
        self.tabImagesRouter.navigationController.navigationBar.isHidden = true
        
        self.tabQuizRouter = RouterType.tabQuiz.router
        self.tabQuizRouter.navigationController.navigationBar.isHidden = true
        
        self.tabSettingsRouter = RouterType.tabSettings.router
        self.tabSettingsRouter.navigationController.navigationBar.isHidden = true
    }
    
    func configure() {
        window.rootViewController = UIStoryboard.init(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()
        
        let state = AccountManager.stateToStart()
        switch state {
        case .login:
            makeLogInRoot()
        case .side:
            makeChooseYourSideRoot()
        case .app:
            makeTabBarRoot()
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
            quizViewController(),
            settingsViewController()
        ]
    }
    
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
    
    func voteViewController() -> UINavigationController {
        let viewController = VoteViewController.instantiate(storyboardName: StoryboardsName.tabVote.rawValue)
        viewController.tabBarItem = UITabBarItem(title: TabBarTitles.vote.rawValue,
                                                 image: UIImage(named: TabBarImages.vote.rawValue),
                                                 tag: 0)
        let configurator = VoteConfigurator()
        configurator.configure(viewController: viewController, coordinator: self)
        tabVoteRouter.navigationController.viewControllers = [viewController]
        return tabVoteRouter.navigationController
    }
    
    func breedsViewController() -> UINavigationController {
        let viewController = BreedsViewController.instantiate(storyboardName: StoryboardsName.tabBreeds.rawValue)
        viewController.tabBarItem = UITabBarItem(title: TabBarTitles.breeds.rawValue,
                                                 image: UIImage(named: TabBarImages.breeds.rawValue),
                                                 tag: 1)
        let configurator = BreedsConfigurator()
        configurator.configure(viewController: viewController, coordinator: self)
        tabBreedsRouter.navigationController.viewControllers = [viewController]
        return tabBreedsRouter.navigationController
    }
    
    func imagesViewController() -> UINavigationController {
        let viewController = ImagesViewController.instantiate(storyboardName: StoryboardsName.tabImages.rawValue)
        viewController.tabBarItem = UITabBarItem(title: TabBarTitles.images.rawValue,
                                                 image: UIImage(named: TabBarImages.images.rawValue),
                                                 tag: 2)
        let configurator = ImagesConfigurator()
        configurator.configure(viewController: viewController, coordinator: self)
        tabImagesRouter.navigationController.viewControllers = [viewController]
        return tabImagesRouter.navigationController
    }
    
    func quizViewController() -> UINavigationController {
        let viewController = QuizViewController.instantiate(storyboardName: StoryboardsName.tabQuiz.rawValue)
        viewController.tabBarItem = UITabBarItem(title: TabBarTitles.quiz.rawValue,
                                                 image: UIImage(named: TabBarImages.quiz.rawValue),
                                                 tag: 3)
        let configurator = QuizConfigurator()
        configurator.configure(viewController: viewController, coordinator: self)
        tabQuizRouter.navigationController.viewControllers = [viewController]
        return tabQuizRouter.navigationController
    }
    
    func settingsViewController() -> UINavigationController {
        let viewController = SettingsViewController.instantiate(storyboardName: StoryboardsName.tabSettings.rawValue)
        viewController.tabBarItem = UITabBarItem(title: TabBarTitles.settings.rawValue,
                                                 image: UIImage(named: TabBarImages.settings.rawValue),
                                                 tag: 4)
        let configurator = SettingsConfigurator()
        configurator.configure(viewController: viewController, coordinator: self)
        tabSettingsRouter.navigationController.viewControllers = [viewController]
        return tabSettingsRouter.navigationController
    }
}