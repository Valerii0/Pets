//
//  ImagesRequestService.swift
//  Pets
//
//  Created by Valerii Petrychenko on 5/15/20.
//  Copyright © 2020 Valerii. All rights reserved.
//

import Foundation

final class ImagesRequestService {
    static func getImages(limit: Int, page: Int?, size: String, order: String?, mimeTypes: String?, categoryIds: Int?, breedIds: String?, callBack: @escaping (_ images: [Image]?, _ error: Error?) -> Void) {
        var urlString = AccountManager.ApiUrl()
        urlString.append(Api.version.rawValue)
        urlString.append(Api.images.rawValue)
        urlString.append(Api.search.rawValue)
        
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = [
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "size", value: size),
            URLQueryItem(name: "sub_id", value: AccountManager.UserId())
        ]
        
        if let page = page {
            urlComponents?.queryItems?.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        
        if let order = order {
            urlComponents?.queryItems?.append(URLQueryItem(name: "order", value: order))
        }
        
        if let mimeTypes = mimeTypes {
            urlComponents?.queryItems?.append(URLQueryItem(name: "mime_types", value: mimeTypes))
        }
        
        if let categoryIds = categoryIds {
            urlComponents?.queryItems?.append(URLQueryItem(name: "category_ids", value: "\(categoryIds)"))
        }
        
        if let breedIds = breedIds {
            urlComponents?.queryItems?.append(URLQueryItem(name: "breed_ids", value: breedIds))
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
                    let images = try JSONDecoder().decode([Image].self, from: data)
                    callBack(images, nil)
                } catch {
                    callBack(nil, error)
                }
            }
        }
        task.resume()
    }
}
