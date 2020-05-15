//
//  Vote.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/15/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

class Vote: Codable {
    var id: String
    var image_id: String
    var sub_id: String
    var created_at: String
    var value: Int
    var country_code: String
}
