//
//  Recipe.swift
//  Xdesign
//
//  Created by flexkid on 08/01/2019.
//  Copyright © 2019 DiegoCaridei. All rights reserved.
//

import Foundation

struct Result: Codable {
    let results: [Recipe]?
}

struct Recipe: Codable {
    let title: String?
    let href: String?
    let ingredients: String?
    let thumbnail: String?
}
