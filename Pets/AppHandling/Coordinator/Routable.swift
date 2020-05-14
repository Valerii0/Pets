//
//  Routable.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/13/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

protocol Routable {
    var navigationController: UINavigationController { get set }
    func push(controller: UIViewController, animated: Bool)
    func present(controller: UIViewController, animated: Bool)
    func pop(animated: Bool)
    func popToRootViewController(animated: Bool)
    func dismiss(animated: Bool)
}

enum RouterType {
    case signIn
    case tabVote
    case tabBreeds
    case tabImages
    case tabQuiz
    case tabSettings
}

extension RouterType {
    var router: Routable {
        switch self {
        case .signIn:
            return SignInRouter()
        case .tabVote:
            return VoteRouter()
        case .tabBreeds:
            return BreedsRouter()
        case .tabImages:
            return ImagesRouter()
        case .tabQuiz:
            return QuizRouter()
        case .tabSettings:
            return SettingsRouter()
        }
    }
}

extension Routable {
    func push(controller: UIViewController, animated: Bool = false) {
        navigationController.pushViewController(controller, animated: animated)
    }
    
    func present(controller: UIViewController, animated: Bool = false) {
        navigationController.present(controller, animated: animated, completion: nil)
    }
    
    func pop(animated: Bool = false) {
        navigationController.popViewController(animated: animated)
    }
    
    func popToRootViewController(animated: Bool = false) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    func dismiss(animated: Bool = false) {
        navigationController.dismiss(animated: animated, completion: nil)
    }
}

class SignInRouter: Routable {
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
    }
}

class VoteRouter: Routable {
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
    }
}

class BreedsRouter: Routable {
    var navigationController: UINavigationController

    init() {
        self.navigationController = UINavigationController()
    }
}

class ImagesRouter: Routable {
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
    }
}

class QuizRouter: Routable {
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
    }
}

class SettingsRouter: Routable {
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
    }
}
