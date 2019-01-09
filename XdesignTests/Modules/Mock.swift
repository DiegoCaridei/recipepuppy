//
//  Mock.swift
//  XdesignTests
//
//  Created by Diego.Caridei on 09/01/2019.
//  Copyright © 2019 DiegoCaridei. All rights reserved.
//

import Foundation
@testable import Xdesign
class MockURLSession: URLSessionProtocol {
    
    func request<T>(url: URL, resource: Resource, completionHandler: @escaping (NetworkResult<T>) -> Void) {
        switch resource {
        case .recipe:
            do {
                if let path = Bundle.main.path(forResource: "feed", ofType: "json") {
                    let text = try String(contentsOfFile: path, encoding: .utf8)
                    let decode = try JSONDecoder().decode(Result.self, from: text.data(using: .utf8)!)  as! T
                    completionHandler(NetworkResult.success(decode))
                }
            }
            catch { completionHandler(NetworkResult.failure(error)) }
        }
    }
}
