//
//  NetworkManager.swift
//  Xdesign
//
//  Created by flexkid on 08/01/2019.
//  Copyright © 2019 DiegoCaridei. All rights reserved.
//

import Foundation

enum Resource {
    case recipe
}

enum Endpoint {
    case recipe(String)
    func url() -> URL {
        switch self {
        case .recipe(let search):
            let escapedString = search.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            let urlRecipe = kBaseURLString + "/api/?q=\(String(describing: search))"
            guard let recipeURL = URL(string: urlRecipe)else {fatalError("Error recipeURL")}
            return recipeURL
        }
    }
}

protocol URLSessionProtocol {
    func request<T>(url:URL,resource: Resource,completionHandler: @escaping (NetworkResult<T>) -> Void)
}

enum NetworkResult<T>: Error {
    case success(T)
    case failure(Error)
}

class NetworkManager {
    
    let session:URLSessionProtocol
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func getRecipe(url:URL,completionHandler:  @escaping (NetworkResult<Result>) -> Void) {
        self.session.request(url: url, resource: .recipe, completionHandler: completionHandler)
    }
}

extension URLSession: URLSessionProtocol {
    
    func request<T>(url: URL,resource: Resource, completionHandler: @escaping (NetworkResult<T>) -> Void)  {
        let task = self.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(NetworkResult.failure(error))
            }
            else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                do {
                    switch resource {
                    case .recipe:
                        guard let decode = try JSONDecoder().decode(Result.self, from: data)  as? T else {
                            
                            if let err = error {completionHandler(NetworkResult.failure(err))}
                            break
                        }
                        completionHandler(NetworkResult.success(decode))
                    }
                }
                catch { completionHandler(NetworkResult.failure(error)) }
            }
        }
        task.resume()
    }
}

