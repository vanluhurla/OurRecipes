//
//  RecipeInstructionCell.swift
//  OurRecipes
//
//  Created by Vanessa Hurla on 09/05/2023.
//

import Foundation
import UIKit

class RecipeInstructionCell: UITableViewCell {
 
    @IBOutlet var recipeInstructionLabel: UILabel!
   
    func setupInstructionCell(instruction: String) {
        recipeInstructionLabel.text = instruction
    }
}
