//
//  DetailRecipeViewControllerTest.swift
//  XdesignTests
//
//  Created by Diego.Caridei on 09/01/2019.
//  Copyright © 2019 DiegoCaridei. All rights reserved.
//

import XCTest
@testable import Xdesign
class DetailRecipeViewControllerTest: XCTestCase {

    var sut: DetailRecipeViewController!
    let test = "Test"
    override func setUp() {
        super.setUp()
        sut = DetailRecipeViewController.instantiate()
        sut.recipe = Recipe(title: test, href: test, ingredients:test , thumbnail: test)
        _ = sut.view
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_containerViewIsNotNil() {
        XCTAssertNotNil(sut.containerView)
    }
    
    func test_fullRecipe() {
        let button = UIButton()
        XCTAssertNotNil(sut.fullRecipe(button))
    }

}
