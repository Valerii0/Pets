//
//  ImagesViewController.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/14/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController, Storyboarded {
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var breedButton: UIButton!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    var presenter: ImagesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        presenter.getCategories()
        presenter.getBreeds()
        presenter.loadImages()
    }
    
    private func setUpUI() {
        coloredBg()
        addLogoToNavigation()
        setUpNavigationBarItemsColor()
        setUpClearButton()
        setUpLabels()
        setUpButtons()
        setUpCollectionView(collectionView: imagesCollectionView)
    }
    
    private func setUpClearButton() {
        let clearButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearFilters(sender:)))
        navigationItem.rightBarButtonItem = clearButton
    }
    
    @objc private func clearFilters(sender: UIBarButtonItem) {
        presenter.clearFilters()
    }
    
    private func setUpLabels() {
        setUpLabel(label: categoryLabel, title: ImagesConstants.category.rawValue)
        setUpLabel(label: breedLabel, title: ImagesConstants.breed.rawValue)
    }
    
    private func setUpLabel(label: UILabel, title: String) {
        label.textColor = CommonValues.buttonsColor
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.text = title
    }
    
    private func setUpButtons() {
        setUpButton(button: categoryButton, title: ImagesConstants.defaultFill.rawValue)
        setUpButton(button: breedButton, title: ImagesConstants.defaultFill.rawValue)
    }
    
    private func setUpButton(button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = CommonValues.buttonsColor
        button.layer.cornerRadius = CommonValues.standardCornerRadius
    }
    
    private func setUpCollectionView(collectionView: UICollectionView) {
        collectionView.layoutIfNeeded()
        let insert: CGFloat = ImagesConstants.indentWith
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
    
    @IBAction func categoryAction(_ sender: UIButton) {
        presenter.pushImagesFilterSelectionViewController(filter: .category)
    }
    
    @IBAction func breedAction(_ sender: UIButton) {
        presenter.pushImagesFilterSelectionViewController(filter: .breed)
    }
}

extension ImagesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.imagesToShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesConstants.imagesCollectionViewCell.rawValue, for: indexPath) as! ImagesCollectionViewCell
        cell.configure(imageUrl: presenter.imagesToShow[indexPath.row].url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.pushLikeViewController(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width - (CGFloat(ImagesConstants.countCellPerRow + 1) * ImagesConstants.indentWith)) / CGFloat(ImagesConstants.countCellPerRow)
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == presenter.imagesToShow.count - 1 && presenter.canLoad {
            presenter.loadImages()
        }
    }
}

extension ImagesViewController: ImagesView {
    func showError(title: String, message: String) {
        self.showAlert(title: title, message: message)
    }
    
    func reloadData() {
        imagesCollectionView.performBatchUpdates({
            imagesCollectionView.reloadSections(IndexSet(integer: 0))
        })
    }
    
    func changeCategory(category: String) {
        categoryButton.setTitle("\(category)", for: .normal)
    }
    
    func changeBreed(breed: String) {
        breedButton.setTitle("\(breed)", for: .normal)
    }
}
