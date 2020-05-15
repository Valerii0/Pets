//
//  Image.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/15/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

class Image: Codable {
    var id: String
    var url: String
    var height: Int
    var width: Int
    var breeds = [Breed]()
    //var categories = [Category]()
}
