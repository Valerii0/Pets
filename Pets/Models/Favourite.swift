//
//  Favourite.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/17/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

class Favourite: Codable {
    var id: Int
    var user_id: String
    var image_id: String
    var sub_id: String
    var created_at: String
    var image: FavouriteImage
}
