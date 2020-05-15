//
//  ImageCache.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/15/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import UIKit

final class ImageCache {
    private let imageCach = NSCache<NSString, UIImage>()
    static let shared = ImageCache()
    private init() {}
    
    func saveImageInCache(image: UIImage, imageName: String) {
        imageCach.setObject(image, forKey: NSString(string: imageName))
    }
    
    func getImageFromCache(imageName: String) -> UIImage? {
        return imageCach.object(forKey: NSString(string: imageName))
    }
    
    func loadImage(imageUrl: String, callBack: @escaping (_ image: UIImage, _ imageUrl: String) -> Void)  {
        if let cachedImage = getImageFromCache(imageName: imageUrl) {
            callBack(cachedImage, imageUrl)
        } else {
            DispatchQueue.global(qos: .userInitiated).async {
                guard let url = URL(string: imageUrl) else { return }
                do {
                    let data = try Data.init(contentsOf: url)
                    if let image = UIImage.init(data: data) {
                        self.saveImageInCache(image: image, imageName: imageUrl)
                        callBack(image, imageUrl)
                    } else {
                        print("can't take an image from data")
                    }
                } catch {
                    print("wrong url - " + "\(url)")
                }
            }
        }
    }
}
