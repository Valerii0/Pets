//
//  BreedsViewController.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/14/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class BreedsViewController: UIViewController, Storyboarded {
    @IBOutlet weak var imagesScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var breedsButton: UIButton!
    
    var presenter: BreedsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//                let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(closeViewController))
//                navigationItem.leftBarButtonItem = cancel
        
        let starImage = UIImage(named: "Icon Info Orange")?.withRenderingMode(.alwaysOriginal)
                let starButton = UIBarButtonItem(image: starImage, style: .plain, target: self, action: #selector(favoriteTapped(sender:)))
                
                       navigationItem.rightBarButtonItem = starButton
            
            
        
//            @objc private func closeViewController() {
//                dismiss(animated: true, completion: nil)
//            }
        
        
        setUpUI()
        presenter.getBreeds()
        imagesScrollView.delegate = self
    }
    
    @objc private func favoriteTapped(sender: UIBarButtonItem) {
//        if sender.tintColor == UIColor.orange {
//            deleteTeamFromRealm(teamDB: teamDB)
//            sender.tintColor = UIColor.gray
//        } else if sender.tintColor == UIColor.gray {
//            addTeamToRealm(teamDB: teamDB)
//            sender.tintColor = UIColor.orange
//        }
    }
    
    private func setUpUI() {
        coloredBg()
        addLogoToNavigation()
        
        setUpButton(button: breedsButton, title: "Choose breed")
        
    }
    
    private func setUpButton(button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = CommonValues.buttonsColor
        button.layer.cornerRadius = CommonValues.standartCornerRadius
    }
    
    @IBAction func breedsAction(_ sender: UIButton) {
    }
    
    func loadImg(url: String, imageView: UIImageView) {
        ImageCache.shared.loadImage(imageUrl: url) { (image, string) in
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
    }
}

extension BreedsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / CGFloat(imagesScrollView.frame.width))
        pageControl.currentPage = Int(pageIndex)
    }
}

extension BreedsViewController: BreedsView {
    func showError(title: String, message: String) {
        self.showAlert(title: title, message: message)
    }
    
    func reloadData() {
        presenter.loadImages()
    }
    
    func reloadImages() {
        pageControl.pageIndicatorTintColor = CommonValues.standardGrayColor
        pageControl.currentPageIndicatorTintColor = CommonValues.buttonsColor
        pageControl.numberOfPages = presenter.images.count
        
        imagesScrollView.contentSize.width = imagesScrollView.frame.width * CGFloat(presenter.images.count)
        imagesScrollView.isPagingEnabled = true
        imagesScrollView.showsHorizontalScrollIndicator = false
        
        for i in 0..<presenter.images.count {
            let imageView = UIImageView()
//            ImageCache.shared.loadImage(imageUrl: presenter.images[i].url) { (image, string) in
//                DispatchQueue.main.async {
//                    self.petImage.image = image
//                }
//            }
            //imageView.image = UIImage(named: AssetsPathConstants.petsLogo.rawValue)
            loadImg(url: presenter.images[i].url, imageView: imageView)
            imageView.contentMode = .scaleAspectFill
            let xPosition = imagesScrollView.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.imagesScrollView.frame.width, height: self.imagesScrollView.frame.height)
            
           
            imagesScrollView.addSubview(imageView)
        }
    }
}
