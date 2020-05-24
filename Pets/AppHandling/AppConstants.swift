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
    case voteSelected = "TabBarTitles/VoteSelected"
    case breeds = "TabBarTitles/Breeds"
    case breedsSelected = "TabBarTitles/BreedsSelected"
    case images = "TabBarTitles/Images"
    case imagesSelected = "TabBarTitles/ImagesSelected"
    case quiz = "TabBarTitles/Quiz"
    case quizSelected = "TabBarTitles/QuizSelected"
    case settings = "TabBarTitles/Settings"
    case settingsSelected = "TabBarTitles/SettingsSelected"
}

enum AssetsPathConstants: String {
    case arrow = "Arrow"
    case buttonDelete = "Buttons/ButtonDelete"
    case buttonDislike = "Buttons/ButtonDislike"
    case buttonLikeGreen = "Buttons/ButtonLikeGreen"
    case buttonLikeRed = "Buttons/ButtonLikeRed"
    case cat = "Cat"
    case chooseYourSide = "ChooseYourSide"
    case dog = "Dog"
    case infoIcon = "Icons/IconInfoOrange"
    case orderIconOrange = "Icons/OrderIconOrange"
    case petsLogo = "PetsLogo"
    case petsShort = "PetsShort"
    case petsTitle = "PetsTitle"
    case deletedTitle = "Titles/Deleted"
    case dislikedTitle = "Titles/Disliked"
    case guessTheBreed = "Titles/GuessTheBreed"
    case likedTitle = "Titles/Liked"
}

enum Api: String {
    case catUrl = "https://api.thecatapi.com"
    case catPicUrl = "https://cdn2.thecatapi.com/images/"
    case catKey = "3352e3fa-4091-4891-9bb6-af69bed52536"
    case dogUrl = "https://api.thedogapi.com"
    case dogPicUrl = "https://cdn2.thedogapi.com/images/"
    case dogKey = "fe910c38-1551-4247-b37a-8145afbdc41c"
    case version = "/v1"
    case breeds = "/breeds"
    case categories = "/categories"
    case votes = "/votes"
    case favourites = "/favourites"
    case images = "/images"
    case search = "/search"
}

enum ImageSizes: String {
    case small = "small"
    case med = "med"
    case full = "full"
}

enum ImageTypes: String {
    case jpg = "jpg"
    case png = "png"
    case gif = "gif"
}

enum ImageOrder: String {
    case Random = "Random"
    case Asc = "Asc"
    case Desc = "Desc"
}

enum LogInConstants: String {
    case generate = "Generate"
    case logIn = "Log In"
    case userId = "User ID"
    case errFirstPart = "Please fill at least"
    case errSecondPart = "characters, but not more"
    case errThirdPart = "."
    
    static let minUserIdLength = 13
    static let maxUserIdLength = 23
}

enum VoteConstants {
    static let maxLimit = 10
    static let minLimit = 5
}

enum BreedsConstants: String {
    case buttonTitle = "Choose breed"
    case prefixSymbol = "•"
    case dividerSymbol = "\n\n"
    case years = "years"
    
    static let imagesLimit = 5
    static let infoViewColor = UIColor(red: 255/255.0, green: 149/255.0, blue: 0/255.0, alpha: 0.8)
}

enum ImagesConstants: String {
    case imagesCollectionViewCell = "ImagesCollectionViewCell"
    case category = "Category"
    case breed = "Breed"
    case defaultFill = "All"
    
    static let countCellPerRow = 3
    static let indentWith: CGFloat = 3
}

enum QuizStartConstants: String {
    case buttonTitle = "Let's go!"
}

enum QuizConstants: String {
    case alertTitle = "Done!"
    case alertMessage = "Your score:"
    
    static let timeLeft: Int = 60
}

enum SettingsConstants: String {
    case userDataTableViewCell = "UserDataTableViewCell"
    case appStateTableViewCell = "AppStateTableViewCell"
    case keyTableViewCell = "KeyTableViewCell"
    case likedPic = "Pictures you've liked"
    case votedPic = "Pictures you've voted"
    case highScore = "Quiz High Score"
    case chooseSide = "Choose your Side"
    case logOut = "Log out"
    case key = "Key: "
    case logOutAsk = "Are you sure you want to logout?"
    case dateFormatFrom = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    case dateFormatTo = "MMM d, h:mm a"
    case points = "points."
}

enum LikedVotedConstants: String {
    case likedVotedCollectionViewCell = "LikedVotedCollectionViewCell"
    
    static let countCellPerRow = 3
    static let indentWith: CGFloat = 3
}

enum SelectionConstants: String {
    case selectionTableViewCell = "SelectionTableViewCell"
}

struct CommonValues {
    static let errorTitle = "Error"
    static let okTitle = "OK"
    static let cancelTitle = "Cancel"
    
    static let standardCornerRadius: CGFloat = 10
    static let collectionCellsCornerRadius: CGFloat = 3
    static let standardTableViewCellHeight: CGFloat = 44
    static let defaultImage = UIImage(named: AssetsPathConstants.petsShort.rawValue) ?? UIImage()
    
    static let bgColor = UIColor(red: 255/255.0, green: 251/255.0, blue: 247/255.0, alpha: 1)
    static let buttonsColor = UIColor(red: 255/255.0, green: 149/255.0, blue: 0/255.0, alpha: 1)
    static let standardGrayColor = UIColor(red: 232/255, green: 233/255, blue: 237/255, alpha: 1)
    
    static let standardBlue = UIColor(red: 26/255, green: 191/255, blue: 251/255, alpha: 0.5)
    static let standardRed = UIColor(red: 255/255, green: 105/255, blue: 91/255, alpha: 0.5)
    static let standardGreen = UIColor(red: 31/255, green: 227/255, blue: 162/255, alpha: 0.5)
}
