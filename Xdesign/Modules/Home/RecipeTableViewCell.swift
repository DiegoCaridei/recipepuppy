//
//  RecipeTableViewCell.swift
//  Xdesign
//
//  Created by flexkid on 08/01/2019.
//  Copyright © 2019 DiegoCaridei. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeNameLabel: UILabel!
    func setCell(recipe: Recipe) {
        
        if let recipeName = recipe.title {
           self.recipeNameLabel.text = recipeName
        }
    }
}
