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
    @IBOutlet weak var breedTextView: UITextView!
    
    var presenter: BreedsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        presenter.getBreeds()
    }
    
    private func setUpUI() {
        coloredBg()
        addLogoToNavigation()
        setUpInfoButton()
        setUpImagesScrollView()
        setUpPageControl()
        setUpButton(button: breedsButton, title: BreedsConstants.buttonTitle.rawValue)
        setUpInfoView()
        setUpNameLabel()
        setUpTextView()
    }
    
    private func setUpInfoButton() {
        let infoImage = UIImage(named: AssetsPathConstants.infoIcon.rawValue)?.withRenderingMode(.alwaysOriginal)
        let infoButton = UIBarButtonItem(image: infoImage, style: .plain, target: self, action: #selector(infoTapped(sender:)))
        navigationItem.rightBarButtonItem = infoButton
    }
    
    @objc private func infoTapped(sender: UIBarButtonItem) {
        infoView.isHidden = !infoView.isHidden
    }
    
    private func setUpImagesScrollView() {
        imagesScrollView.layer.cornerRadius = CommonValues.standardCornerRadius
        imagesScrollView.isPagingEnabled = true
        imagesScrollView.showsHorizontalScrollIndicator = false
        imagesScrollView.delegate = self
    }
    
    private func setUpPageControl() {
        pageControl.pageIndicatorTintColor = CommonValues.standardGrayColor
        pageControl.currentPageIndicatorTintColor = CommonValues.buttonsColor
        pageControl.numberOfPages = 0
    }
    
    private func setUpButton(button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = CommonValues.buttonsColor
        button.layer.cornerRadius = CommonValues.standardCornerRadius
    }
    
    private func setUpInfoView() {
        infoView.isHidden = true
        infoView.backgroundColor = BreedsConstants.infoViewColor
        infoView.layer.cornerRadius = CommonValues.standardCornerRadius
    }
    
    private func setUpNameLabel() {
        breedLabel.textColor = .white
        breedLabel.textAlignment = .left
        breedLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        breedLabel.numberOfLines = 0
        breedLabel.text = nil
    }
    
    private func setUpTextView() {
        breedTextView.backgroundColor = .clear
        breedTextView.textAlignment = .left
        breedTextView.textColor = .white
        breedTextView.isEditable = false
        breedTextView.isSelectable = false
    }
    
    private func configure(breed: Breed) {
        breedLabel.text = breed.name
        
        var text = ""
        if let description = breed.description, description.count > 0 {
            text.append("\(BreedsConstants.prefixSymbol.rawValue) \(description)\(BreedsConstants.dividerSymbol.rawValue)")
        }
        if let temperament = breed.temperament, temperament.count > 0 {
            text.append("\(BreedsConstants.prefixSymbol.rawValue) \(temperament)\(BreedsConstants.dividerSymbol.rawValue)")
        }
        if let origin = breed.origin, origin.count > 0 {
            text.append("\(BreedsConstants.prefixSymbol.rawValue) \(origin)\(BreedsConstants.dividerSymbol.rawValue)")
        }
        if let life_span = breed.life_span, life_span.count > 0 {
            text.append("\(BreedsConstants.prefixSymbol.rawValue) \(life_span) \(BreedsConstants.years.rawValue)\(BreedsConstants.dividerSymbol.rawValue)")
        }
        breedTextView.text = text
    }
    
    private func clearScrollView() {
        imagesScrollView.subviews.forEach({ $0.removeFromSuperview() })
        imagesScrollView.contentSize.width = imagesScrollView.frame.width * CGFloat(0)
    }
    
    private func configureScrollView() {
        imagesScrollView.contentSize.width = imagesScrollView.frame.width * CGFloat(presenter.imagesToShow.count)
        pageControl.numberOfPages = presenter.imagesToShow.count > 1 ? presenter.imagesToShow.count : 1
        
        if presenter.imagesToShow.count == 0 {
            fillScrollView(index: nil)
        } else {
            for imageIndex in 0..<presenter.imagesToShow.count {
                fillScrollView(index: imageIndex)
            }
        }
    }
    
    private func fillScrollView(index: Int?) {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        var xPosition: CGFloat = 0.0
        if let index = index {
            loadImage(imageUrl: presenter.imagesToShow[index].url, imageView: imageView)
            xPosition = imagesScrollView.frame.width * CGFloat(index)
        } else {
            imageView.image = CommonValues.defaultImage
            xPosition = imagesScrollView.frame.width * CGFloat(0)
        }
        imageView.frame = CGRect(x: xPosition, y: 0, width: self.imagesScrollView.frame.width, height: self.imagesScrollView.frame.height)
        imagesScrollView.addSubview(imageView)
    }
    
    @IBAction func breedsAction(_ sender: UIButton) {
        presenter.pushBreedsSelectionViewController()
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
        clearScrollView()
        configureScrollView()
    }
    
    func loadBreedInfo(breed: Breed) {
        configure(breed: breed)
    }
}
