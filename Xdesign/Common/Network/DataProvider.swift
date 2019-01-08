//
//  DataProvider.swift
//  Xdesign
//
//  Created by flexkid on 08/01/2019.
//  Copyright © 2019 DiegoCaridei. All rights reserved.
//

import Foundation

protocol DataProviderProtocol {
    func getRecipe(recipe: String, completionHandler: @escaping([Recipe]) -> ())
}

class DataProvider:DataProviderProtocol {
    private var session: URLSessionProtocol!
    
    init(session:URLSessionProtocol = URLSession.shared ) {
        self.session = session
    }
    
    func getRecipe(recipe: String, completionHandler: @escaping([Recipe]) -> ()){
        let background = DispatchQueue.global()
        background.async {
            let manager = NetworkManager(session: self.session )
            manager.getRecipe(url: Endpoint.recipe(recipe).url()) { (resp) in
                switch resp {
                case .success(let res):
                    if let recipes = res.results { completionHandler(recipes)}
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        }
    }
}
