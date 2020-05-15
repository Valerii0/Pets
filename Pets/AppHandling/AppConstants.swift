//
//  AppConstants.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/13/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

enum State {
    case login
    case side
    case app
}

enum Side: String {
    case cat = "cat"
    case dog = "dog"
}

enum UserDefaultsValues: String {
    case loginId = "loginId"
    case side = "side"
}

enum TabBarTitles: String {
    case vote = "Vote"
    case breeds = "Breeds"
    case images = "Images"
    case quiz = "Quiz"
    case settings = "Settings"
}

enum TabBarImages: String {
    case vote = "TabBarTitles/Vote"
    case breeds = "TabBarTitles/Breeds"
    case images = "TabBarTitles/Images"
    case quiz = "TabBarTitles/Quiz"
    case settings = "TabBarTitles/Settings"
}

enum AssetsPathConstants: String {
    case pets = "Pets"
    case chooseYourSide = "ChooseYourSide"
    case dog = "Dog"
    case cat = "Cat"
}

enum Api: String {
    case catUrl = "https://api.thecatapi.com"
    case catKey = "3352e3fa-4091-4891-9bb6-af69bed52536"
    case dogUrl = "https://api.thedogapi.com"
    case dogKey = "fe910c38-1551-4247-b37a-8145afbdc41c"
    case version = "/v1"
    case breeds = "/breeds"
    case categories = "/categories"
    case votes = "/votes"
    case favourites = "/favourites"
    case images = "/images"
    case search = "/search"
}

enum LogInConstants: String {
    case generate = "Generate"
    case logIn = "Log In"
    case userId = "User ID"
}

struct CommonValues {
    static let mainSound = "original"
    static let standartCornerRadius: CGFloat = 10
}
