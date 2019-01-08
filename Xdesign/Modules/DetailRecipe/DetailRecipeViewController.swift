//
//  DetailRecipeViewController.swift
//  Xdesign
//
//  Created by flexkid on 08/01/2019.
//  Copyright © 2019 DiegoCaridei. All rights reserved.
//

import UIKit

class DetailRecipeViewController: BaseViewController {
    
    @IBOutlet weak var containerView: DetailView!
    weak var coordinator: MainCoordinator?
    var recipe: Recipe!
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.setup(recipe: recipe)
    }
    
    @IBAction func fullRecipe(_ sender: Any) {
        if let urlString = recipe.href { coordinator?.visitFullRecipe(from: urlString)}
    }
}
