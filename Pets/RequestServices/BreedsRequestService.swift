//
//  BreedsRequestService.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/16/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

final class BreedsRequestService {
    static func getBreeds(limit: Int?, page: Int?, callBack: @escaping (_ breeds: [Breed]?, _ error: Error?) -> Void) {
        var urlString = AccountManager.ApiUrl()
        urlString.append(Api.version.rawValue)
        urlString.append(Api.breeds.rawValue)
        
        var urlComponents = URLComponents(string: urlString)
        
        if let limit = limit {
            urlComponents?.queryItems?.append(URLQueryItem(name: "limit", value: "\(limit)"))
        }
        
        if let page = page {
            urlComponents?.queryItems?.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        
        var request = URLRequest(url: (urlComponents?.url)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(AccountManager.ApiKey(), forHTTPHeaderField: "x-api-key")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                callBack(nil, error)
            } else if let data = data {
                do {
                    let breeds = try JSONDecoder().decode([Breed].self, from: data)
                    callBack(breeds, nil)
                } catch {
                    callBack(nil, error)
                }
            }
        }
        task.resume()
    }
}
