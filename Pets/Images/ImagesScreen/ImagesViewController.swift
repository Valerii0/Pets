//
//  ImagesViewController.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/14/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController, Storyboarded {
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var typeButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var breedButton: UIButton!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    var presenter: ImagesPresenter!
    
    private let countCellPerRow = 3
    private let indentWith: CGFloat = 3
    //private var images = [Image]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        presenter.getBreeds()
        presenter.loadImages()
    }
    
    private func setUpUI() {
        coloredBg()
        addLogoToNavigation()
        
        setUpButtons()
        setUpCollectionView(collectionView: imagesCollectionView)
    }
    
    private func setUpButtons() {
        setUpButton(button: orderButton, title: ImagesConstants.order.rawValue)
        setUpButton(button: typeButton, title: ImagesConstants.type.rawValue)
        setUpButton(button: categoryButton, title: ImagesConstants.category.rawValue)
        setUpButton(button: breedButton, title: ImagesConstants.breed.rawValue)
    }
    
    private func setUpButton(button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = CommonValues.buttonsColor
        button.layer.cornerRadius = CommonValues.standartCornerRadius
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
    
    @IBAction func orderAction(_ sender: UIButton) {
        presenter.pushImagesFilterSelectionViewController(filter: .order)
    }
    
    @IBAction func typeAction(_ sender: UIButton) {
        presenter.pushImagesFilterSelectionViewController(filter: .type)
    }
    
    @IBAction func categoryAction(_ sender: UIButton) {
        presenter.pushImagesFilterSelectionViewController(filter: .category)
    }
    
    @IBAction func breedAction(_ sender: UIButton) {
        presenter.pushImagesFilterSelectionViewController(filter: .breed)
    }
}

extension ImagesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesConstants.imagesCollectionViewCell.rawValue, for: indexPath) as! ImagesCollectionViewCell
        cell.configure(imageUrl: presenter.images[indexPath.row].url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.pushLikeViewController(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width - (CGFloat(countCellPerRow + 1) * indentWith)) / CGFloat(countCellPerRow)
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == presenter.images.count - 1 { //&& isCardsExist {
            //presenter.getFilteredCards(skip: self.cardsArray.count, cefr: cefr, type: type, magic: magic, word: word, firstLoad: false)
            //loadDataSource()
            presenter.loadImages()
        }
    }
}

extension ImagesViewController: ImagesView {
    func showError(title: String, message: String) {
        self.showAlert(title: title, message: message)
    }
    
    func reloadData() {
        imagesCollectionView.reloadData()
    }
    
    func breedBu(breed: String) {
        breedButton.setTitle("\(ImagesConstants.breed.rawValue) \(breed)", for: .normal)
    }
}
