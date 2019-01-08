//
//  DetailView.swift
//  Xdesign
//
//  Created by flexkid on 08/01/2019.
//  Copyright © 2019 DiegoCaridei. All rights reserved.
//

import UIKit
import Kingfisher
class DetailView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    convenience init(frame: CGRect, recipe: Recipe) {
        self.init(frame: frame)
        self.setup(recipe: recipe)
    }
    
    fileprivate func commonInit() {
        Bundle.main.loadNibNamed(kDetailView, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
    }
    
     func setup(recipe: Recipe) {
        if let title = recipe.title { recipeTitleLabel.text = title }
        if let ingredient = recipe.ingredients { ingredientsTextView.text = kIngredients + ingredient}
        if let stringURL = recipe.thumbnail, let url = URL(string: stringURL) {
            imageView.kf.setImage(with: url)
        }
    }
    
}
