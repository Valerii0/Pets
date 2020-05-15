//
//  ImagesCollectionViewCell.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/15/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

class ImagesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var petImage: UIImageView!
    
    private var imageUrl: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = CommonValues.collectionCellsCornerRadius
        petImage.contentMode = .scaleAspectFill
        //likeButton.layer.cornerRadius = 3
        
        //likeButton.setTitle(nil, for: .normal)
    }
    
    func configure(imageUrl: String) {
        self.imageUrl = imageUrl
        loadImage(imageUrl: imageUrl)
    }
    
    private func loadImage(imageUrl: String) {
        petImage.image = nil
        //likeButton.backgroundColor = .clear
        ImageCache.shared.loadImage(imageUrl: imageUrl) { (image, imageUrl) in
            if self.imageUrl == imageUrl {
                DispatchQueue.main.async {
                    self.petImage.image = image
                    //self.likeButton.backgroundColor = .red
                }
            }
        }
    }
    
//    @IBAction func likeAction(_ sender: UIButton) {
//        if let imageId = image?.id {
//            let postFavourite = PostFavourite(image_id: imageId, sub_id: UIDevice.current.identifierForVendor!.uuidString)
//            FavouritesRequestService.postFavourite(favourite: postFavourite) { (error) in
//                print(error?.localizedDescription)
//            }
//        }
//    }

}
