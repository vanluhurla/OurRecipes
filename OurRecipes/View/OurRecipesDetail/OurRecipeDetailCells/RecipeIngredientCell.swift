//
//  RecipeIngredientCell.swift
//  OurRecipes
//
//  Created by Vanessa Hurla on 09/05/2023.
//

import Foundation
import UIKit

class RecipeIngredientCell: UITableViewCell {
    
    @IBOutlet var recipeIngredientLabel: UILabel!
    
    func setupIngredientCell(ingredient: String) {
        recipeIngredientLabel.text = ingredient
    }
    
}
