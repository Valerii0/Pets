//
//  Breed.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/15/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

final class Breed: Codable {
    var id: String
    var name: String
    var description: String?
    var temperament: String?
    var life_span: String?
    var alt_names: String?
    var wikipedia_url: String?
    var origin: String?
    var country_code: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", name = "name", description = "description", temperament = "temperament", life_span = "life_span",
        alt_names = "alt_names", wikipedia_url = "wikipedia_url", origin = "origin", country_code = "country_code"
    }
    
    init(id: String, name: String, description: String? = nil, temperament: String? = nil, life_span: String? = nil,
         alt_names: String? = nil, wikipedia_url: String? = nil, origin: String? = nil, country_code: String? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.temperament = temperament
        self.life_span = life_span
        self.alt_names = alt_names
        self.wikipedia_url = wikipedia_url
        self.origin = origin
        self.country_code = country_code
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(Int.self, forKey: .id) {
            id = String(value)
        } else {
            id = try container.decode(String.self, forKey: .id)
        }
        name = try container.decode(String.self, forKey: .name)
        description = try? container.decode(String.self, forKey: .description)
        temperament = try? container.decode(String.self, forKey: .temperament)
        life_span = try? container.decode(String.self, forKey: .life_span)
        alt_names = try? container.decode(String.self, forKey: .alt_names)
        wikipedia_url = try? container.decode(String.self, forKey: .wikipedia_url)
        origin = try? container.decode(String.self, forKey: .origin)
        country_code = try? container.decode(String.self, forKey: .country_code)
    }
}
