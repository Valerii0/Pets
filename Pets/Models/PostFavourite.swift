//
//  PostFavourite.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/17/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

class PostFavourite: Codable {
    var image_id: String
    var sub_id: String
    
    init(image_id: String, sub_id: String) {
        self.image_id = image_id
        self.sub_id = sub_id
    }
}
