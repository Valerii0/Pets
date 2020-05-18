//
//  ScoreRequestService.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/18/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

final class ScoreRequestService {
    static func getScores(limit: Int, page: Int, callBack: @escaping (_ favourites: [Favourite]?, _ error: Error?) -> Void) {
        var urlString = AccountManager.ApiUrl()
        urlString.append(Api.version.rawValue)
        urlString.append(Api.favourites.rawValue)
        
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = [
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "sub_id", value: AccountManager.UserScoreId())
        ]
        
        var request = URLRequest(url: (urlComponents?.url)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(AccountManager.ApiKey(), forHTTPHeaderField: "x-api-key")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                callBack(nil, error)
            } else if let data = data {
                do {
                    let favourites = try JSONDecoder().decode([Favourite].self, from: data)
                    callBack(favourites, nil)
                } catch {
                    callBack(nil, error)
                }
            }
        }
        task.resume()
    }
    
    static func postScore(postScore: PostFavourite, callBack: @escaping (_ error: Error?) -> Void) {
        var urlString = AccountManager.ApiUrl()
        urlString.append(Api.version.rawValue)
        urlString.append(Api.favourites.rawValue)
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(AccountManager.ApiKey(), forHTTPHeaderField: "x-api-key")
        request.httpBody = try? JSONEncoder().encode(postScore)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            callBack(error)
        }
        task.resume()
    }
}
