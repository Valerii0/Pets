//
//  VotesRequestService.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/15/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

final class VotesRequestService {
    static func getVotes(limit: Int, page: Int, callBack: @escaping (_ votes: [Vote]?, _ error: Error?) -> Void) {
        var urlString = AccountManager.ApiUrl()
        urlString.append(Api.version.rawValue)
        urlString.append(Api.votes.rawValue)
        
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = [
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "sub_id", value: AccountManager.UserId())
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
                    let votes = try JSONDecoder().decode([Vote].self, from: data)
                    callBack(votes, nil)
                } catch {
                    callBack(nil, error)
                }
            }
        }
        task.resume()
    }
    
    static func postVote(vote: PostVote, callBack: @escaping (_ error: Error?) -> Void) {
        var urlString = AccountManager.ApiUrl()
        urlString.append(Api.version.rawValue)
        urlString.append(Api.votes.rawValue)
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(AccountManager.ApiKey(), forHTTPHeaderField: "x-api-key")
        request.httpBody = try? JSONEncoder().encode(vote)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            callBack(error)
        }
        task.resume()
    }
    
    static func delVote(voteId: Int, callBack: @escaping (_ error: Error?) -> Void) {
        var urlString = AccountManager.ApiUrl()
        urlString.append(Api.version.rawValue)
        urlString.append(Api.votes.rawValue)
        urlString.append("/\(voteId)")
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(AccountManager.ApiKey(), forHTTPHeaderField: "x-api-key")
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            callBack(error)
        }
        task.resume()
    }
    
    static func getSpecificVote(voteId: Int, callBack: @escaping (_ error: Error?) -> Void) {
        var urlString = AccountManager.ApiUrl()
        urlString.append(Api.version.rawValue)
        urlString.append(Api.votes.rawValue)
        urlString.append("/\(voteId)")
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(AccountManager.ApiKey(), forHTTPHeaderField: "x-api-key")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            callBack(error)
        }
        task.resume()
    }
}
