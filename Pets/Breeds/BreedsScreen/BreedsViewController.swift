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
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var breedsButton: UIButton!
    
    var presenter: BreedsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        presenter.getBreeds()
    }
    
    private func setUpUI() {
        coloredBg()
        addLogoToNavigation()
        
        setUpButton(button: breedsButton, title: "Choose breed")
        
        let starImage = UIImage(named: "Icon Info Orange")?.withRenderingMode(.alwaysOriginal)
        let starButton = UIBarButtonItem(image: starImage, style: .plain, target: self, action: #selector(favoriteTapped(sender:)))
        navigationItem.rightBarButtonItem = starButton
        
        pageControl.pageIndicatorTintColor = CommonValues.standardGrayColor
        pageControl.currentPageIndicatorTintColor = CommonValues.buttonsColor
        pageControl.numberOfPages = 0
        
        imagesScrollView.layer.cornerRadius = CommonValues.standartCornerRadius
        imagesScrollView.isPagingEnabled = true
        imagesScrollView.showsHorizontalScrollIndicator = false
        //imagesScrollView.setZoomScale(1.0, animated: true)
        imagesScrollView.delegate = self
        
        infoView.isHidden = true
        infoView.backgroundColor = BreedsConstants.infoViewColor
        infoView.layer.cornerRadius = CommonValues.standartCornerRadius
        breedLabel.text = "Random"
    }
    
    //                let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(closeViewController))
    //                navigationItem.leftBarButtonItem = cancel
    
    
    //            @objc private func closeViewController() {
    //                dismiss(animated: true, completion: nil)
    //            }
    
    @objc private func favoriteTapped(sender: UIBarButtonItem) {
        infoView.isHidden = !infoView.isHidden
        //        if sender.tintColor == UIColor.orange {
        //            deleteTeamFromRealm(teamDB: teamDB)
        //            sender.tintColor = UIColor.gray
        //        } else if sender.tintColor == UIColor.gray {
        //            addTeamToRealm(teamDB: teamDB)
        //            sender.tintColor = UIColor.orange
        //        }
    }
    
    private func setUpButton(button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = CommonValues.buttonsColor
        button.layer.cornerRadius = CommonValues.standartCornerRadius
    }
    
    @IBAction func breedsAction(_ sender: UIButton) {
        presenter.pushBreedsSelectionViewController()
    }
    
    private func loadImg(url: String, imageView: UIImageView) {
        ImageCache.shared.loadImage(imageUrl: url) { (image, string) in
            DispatchQueue.main.async {
                imageView.image = image
                imageView.contentMode = .scaleAspectFill
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
    
    func reloadImages() {
        imagesScrollView.subviews.forEach({ $0.removeFromSuperview() })
        imagesScrollView.contentSize.width = imagesScrollView.frame.width * CGFloat(0)
        if presenter.images.count == 0 {
            imagesScrollView.contentSize.width = imagesScrollView.frame.width * CGFloat(0)
            pageControl.numberOfPages = 1
            
            let imageView = UIImageView()
            imageView.clipsToBounds = true
            imageView.image = CommonValues.defaultImage
            let xPosition = imagesScrollView.frame.width * CGFloat(0)
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.imagesScrollView.frame.width, height: self.imagesScrollView.frame.height)
            imagesScrollView.addSubview(imageView)
            
        } else {
            imagesScrollView.contentSize.width = imagesScrollView.frame.width * CGFloat(presenter.images.count)
            pageControl.numberOfPages = presenter.images.count
            //pageControl.currentPage = 0
            
            for i in 0..<presenter.images.count {
                let imageView = UIImageView()
                imageView.clipsToBounds = true
                loadImg(url: presenter.images[i].url, imageView: imageView)
                let xPosition = imagesScrollView.frame.width * CGFloat(i)
                imageView.frame = CGRect(x: xPosition, y: 0, width: self.imagesScrollView.frame.width, height: self.imagesScrollView.frame.height)
                
                imagesScrollView.addSubview(imageView)
            }
        }
    }
}
