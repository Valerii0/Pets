//
//  LikedVotedViewController.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/17/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class LikedVotedViewController: UIViewController, Storyboarded {
    @IBOutlet weak var likedVotedCollectionView: UICollectionView!
    
    var presenter: LikedVotedPresenter!
    
    private let countCellPerRow = 3
    private let indentWith: CGFloat = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        presenter.loadImages()
    }
    
    private func setUpUI() {
        coloredBg()
        addLogoToNavigation()
        
        setUpCollectionView(collectionView: likedVotedCollectionView)
    }
    
    private func setUpCollectionView(collectionView: UICollectionView) {
        collectionView.layoutIfNeeded()
        let insert: CGFloat = indentWith//(collectionView.frame.width / CGFloat(countCellPerRow + 1)) / CGFloat(countCellPerRow + 1)
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: insert, left: insert, bottom: insert, right: insert)
        layout.minimumLineSpacing = insert
        layout.minimumInteritemSpacing = insert
        collectionView.collectionViewLayout = layout
        collectionView.layer.cornerRadius = CommonValues.collectionCellsCornerRadius
        collectionView.backgroundColor = .clear
        collectionView.register(UINib(nibName: ImagesConstants.imagesCollectionViewCell.rawValue, bundle: nil),
                                forCellWithReuseIdentifier: ImagesConstants.imagesCollectionViewCell.rawValue)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension LikedVotedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.favourites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesConstants.imagesCollectionViewCell.rawValue, for: indexPath) as! ImagesCollectionViewCell
        cell.configure(imageUrl: presenter.favourites[indexPath.row].image.url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let learningBlock = LearningBlock(rawValue: indexPath.row) {
//            presenter.selectModule(learningBlock: learningBlock)
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width - (CGFloat(countCellPerRow + 1) * indentWith)) / CGFloat(countCellPerRow)
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == presenter.votes.count - 1 { //&& isCardsExist {
            //presenter.getFilteredCards(skip: self.cardsArray.count, cefr: cefr, type: type, magic: magic, word: word, firstLoad: false)
            //loadDataSource()
            presenter.loadImages()
        }
    }
}

extension LikedVotedViewController: LikedVotedView {
    func showError(title: String, message: String) {
        self.showAlert(title: title, message: message)
    }
    
    func reloadData() {
        likedVotedCollectionView.reloadData()
    }
}
