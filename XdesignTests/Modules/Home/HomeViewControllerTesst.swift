//
//  HomeViewControllerTesst.swift
//  XdesignTests
//
//  Created by Diego.Caridei on 09/01/2019.
//  Copyright © 2019 DiegoCaridei. All rights reserved.
//

import XCTest
@testable import Xdesign
class HomeViewControllerTesst: XCTestCase {

    var sut: HomeViewController!
    var mock: MockURLSession!
    override func setUp() {
        super.setUp()
        mock = MockURLSession()
        makeSUT()
    }

    override func tearDown() {
        sut = nil
        mock = nil
        super.tearDown()
    }

    func test_tableViewHasDataSourceAndDelegate() {
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertNotNil(sut.tableView.delegate)
    }
    
    func test_numberOfRowsInSection_And_TableViewCellHasReuseIdentifier(){
        let dataProvider = DataProvider(session: mock)
        let exp = self.expectation(description: "Read File")
        
        dataProvider.getRecipe(recipe: "") { [weak self] (rec) in
            guard let self = self else {return}
            self.sut.reloadData(rec: rec)
            exp.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(self.sut.tableView(self.sut.tableView, numberOfRowsInSection: 0), 10)
        
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? RecipeTableViewCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "RecipeTableViewCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
    
    func test_conformsToUISearchResultsUpdating() {
        XCTAssert(sut.conforms(to: UISearchResultsUpdating.self))
    }
    
    func test_conformsToUITableViewDelegates() {
        XCTAssert(sut.conforms(to: UITableViewDelegate.self))
        XCTAssert(sut.conforms(to: UITableViewDataSource.self))
    }
    
    
    //Helper functions
    func makeSUT() {
        sut  = HomeViewController.instantiate()
        _ = sut.view
    }
}
