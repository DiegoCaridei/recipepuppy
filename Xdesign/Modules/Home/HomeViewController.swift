//
//  HomeViewController.swift
//  Xdesign
//
//  Created by flexkid on 08/01/2019.
//  Copyright © 2019 DiegoCaridei. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var recipes = [Recipe]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var dataProvider: DataProviderProtocol!
    weak var coordinator: MainCoordinator?
    convenience init(dataProvider: DataProviderProtocol) {
        self.init()
        self.dataProvider = dataProvider
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    fileprivate func setup() {
        
        if self.dataProvider == nil {dataProvider = DataProvider()}
        self.definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = kSearchRecipes
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    fileprivate func reloadData(rec: [Recipe]) {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.recipes = rec
            self.tableView.reloadData()
        }
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count > 1 {
            dataProvider.getRecipe(recipe: text) {  (recipes) in
                self.reloadData(rec: recipes)
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        coordinator?.detailRecipe(recipe: recipe)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kRecipeTableViewCellIDentifier, for: indexPath) as? RecipeTableViewCell else {
            fatalError("Error dequeueReusableCell on RecipeTableViewCell")}
        let recipe = recipes[indexPath.row]
        cell.setCell(recipe: recipe)
        return cell
    }
}
