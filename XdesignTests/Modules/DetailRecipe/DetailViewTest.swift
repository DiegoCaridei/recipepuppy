//
//  DetailViewTest.swift
//  XdesignTests
//
//  Created by Diego.Caridei on 09/01/2019.
//  Copyright © 2019 DiegoCaridei. All rights reserved.
//

import XCTest
@testable import Xdesign
class DetailViewTest: XCTestCase {

    var sut: DetailView!
    let size = 100
    let title = "Title"
    let ingredients = "Sugo"
    let href = "www.test.org"
    var recipe: Recipe!
    override func setUp() {
        super.setUp()
        recipe = Recipe (title: title, href: href, ingredients: nil, thumbnail: nil)
        sut = DetailView(frame: CGRect(x: size, y: size, width: size, height: size), recipe: recipe)
    }

    override func tearDown() {
        sut  = nil
        recipe = nil
        super.tearDown()
    }

    func test_ingredientsTextView() {
        XCTAssertEqual(sut.ingredientsTextView.text!, "")
    }
    
    func test_recipeTitleLabel() {

        XCTAssertEqual(sut.recipeTitleLabel.text!, title)
    }
    
    func test_setup() {
        XCTAssertNotNil(sut.setup(recipe: recipe))
    }

}
