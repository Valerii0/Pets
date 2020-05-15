//
//  PostVote.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/15/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

class PostVote: Codable {
    var image_id: String
    var value: Bool
    var sub_id: String
    
    init(image_id: String, value: Bool, sub_id: String) {
        self.image_id = image_id
        self.value = value
        self.sub_id = sub_id
    }
}
