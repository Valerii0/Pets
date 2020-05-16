//
//  LikedVotedCollectionViewCell.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/17/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class LikedVotedCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var petImage: UIImageView!
    
    private var imageUrl: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = CommonValues.collectionCellsCornerRadius
        petImage.contentMode = .scaleAspectFill
    }
    
    func configure(imageUrl: String) {
        self.imageUrl = imageUrl
        loadImage(imageUrl: imageUrl)
    }
    
    private func loadImage(imageUrl: String) {
        petImage.image = nil
        ImageCache.shared.loadImage(imageUrl: imageUrl) { (image, imageUrl) in
            if self.imageUrl == imageUrl {
                DispatchQueue.main.async {
                    self.petImage.image = image
                }
            }
        }
    }
}
