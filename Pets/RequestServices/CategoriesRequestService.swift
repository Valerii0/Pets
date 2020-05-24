//
//  CategoriesRequestService.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/20/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

final class CategoriesRequestService {
    static func getCategories(callBack: @escaping (_ categories: [Category]?, _ error: Error?) -> Void) {
        var urlString = AccountManager.ApiUrl()
        urlString.append(Api.version.rawValue)
        urlString.append(Api.categories.rawValue)
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(AccountManager.ApiKey(), forHTTPHeaderField: "x-api-key")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                callBack(nil, error)
            } else if let data = data {
                do {
                    let categories = try JSONDecoder().decode([Category].self, from: data)
                    callBack(categories, nil)
                } catch {
                    callBack(nil, error)
                }
            }
        }
        task.resume()
    }
}
