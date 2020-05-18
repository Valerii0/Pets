//
//  Breed.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/15/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

class Breed: Codable {
    var id: String
    var name: String
    var description: String?
    var temperament: String?
    var life_span: String?
    var alt_names: String?
    var wikipedia_url: String?
    var origin: String?
    var country_code: String?
}
