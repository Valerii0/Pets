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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        presenter.loadImages()
    }
    
    private func setUpUI() {
        coloredBg()
        addLogoToNavigation()
        setUpNavigationBarItemsColor()
        setUpSortButton()
        setUpCollectionView(collectionView: likedVotedCollectionView)
    }
    
    private func setUpSortButton() {
        let sortImage = UIImage(named: AssetsPathConstants.orderIconOrange.rawValue)?.withRenderingMode(.alwaysOriginal)
        let sortButton = UIBarButtonItem(image: sortImage, style: .plain, target: self, action: #selector(sortTapped(sender:)))
        navigationItem.rightBarButtonItem = sortButton
    }
    
    @objc private func sortTapped(sender: UIBarButtonItem) {
        presenter.sort()
    }
    
    private func setUpCollectionView(collectionView: UICollectionView) {
        collectionView.layoutIfNeeded()
        let insert: CGFloat = LikedVotedConstants.indentWith
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: insert, left: insert, bottom: insert, right: insert)
        layout.minimumLineSpacing = insert
        layout.minimumInteritemSpacing = insert
        collectionView.collectionViewLayout = layout
        collectionView.layer.cornerRadius = CommonValues.collectionCellsCornerRadius
        collectionView.backgroundColor = .clear
        collectionView.register(UINib(nibName: LikedVotedConstants.likedVotedCollectionViewCell.rawValue, bundle: nil),
                                forCellWithReuseIdentifier: LikedVotedConstants.likedVotedCollectionViewCell.rawValue)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension LikedVotedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.imagesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikedVotedConstants.likedVotedCollectionViewCell.rawValue, for: indexPath) as! LikedVotedCollectionViewCell
        cell.configure(imageUrl: presenter.imageUrl(index: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.imagePressed(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width - (CGFloat(LikedVotedConstants.countCellPerRow + 1) * LikedVotedConstants.indentWith)) / CGFloat(LikedVotedConstants.countCellPerRow)
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == presenter.imagesCount() - 1 && presenter.canLoad() {
            presenter.loadImages()
        }
    }
}

extension LikedVotedViewController: LikedVotedView {
    func showError(title: String, message: String) {
        self.showAlert(title: title, message: message)
    }
    
    func reloadData() {
        likedVotedCollectionView.performBatchUpdates({
            likedVotedCollectionView.reloadSections(IndexSet(integer: 0))
        })
    }
}
