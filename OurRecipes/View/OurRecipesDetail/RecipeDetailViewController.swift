//
//  RecipeDetailViewController.swift
//  OurRecipes
//
//  Created by Vanessa Hurla on 01/05/2023.
//

import UIKit

enum RecipeDetailsSection: Int {
    case ingredients, instructions
}

class RecipeDetailViewController: UIViewController {
    
    
    @IBOutlet var recipeDetailImageView: UIImageView!
    @IBOutlet var recipeDetailTableView: UITableView!    
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    var recipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = recipe?.title
        
        setupTableView()
        setupImage()
    }
    
    func setupImage() {
        guard let image = recipe?.image else {
            return
        }
        loadingIndicator.startAnimating()
        loadingIndicator.hidesWhenStopped = true
        recipeDetailImageView.downloadImage(from: image) { [weak self] in
            self?.loadingIndicator.stopAnimating()
        }
    }
    
    func setupTableView() {
        recipeDetailTableView.register(UINib(nibName: "RecipeIngredientCell", bundle: nil), forCellReuseIdentifier: "ReusableRecipeIngredientCell")
        recipeDetailTableView.register(UINib(nibName: "RecipeInstructionCell", bundle: nil), forCellReuseIdentifier: "ReusableRecipeInstructionCell")
        recipeDetailTableView.dataSource = self
    }
}

// MARK: TABLEVIEW DATASOURCE
    
extension RecipeDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let myRecipe = recipe else {
            return 0
        }
        switch RecipeDetailsSection(rawValue: section) {
        case .ingredients:
            return myRecipe.ingredients.count
        case .instructions:
            return myRecipe.instructions.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return createIngredientCell(indexPath: indexPath)
        case 1:
            return createInstructionCell(indexPath: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Ingredients"
        case 1:
            return "Instructions"
        default:
            return nil
        }
    }
}
    
    // MARK: CELL CREATION
    
    extension RecipeDetailViewController {
        func createIngredientCell(indexPath: IndexPath) -> UITableViewCell {
            guard let myRecipe = recipe else {
                return UITableViewCell ()
            }
            
            if let cell = recipeDetailTableView.dequeueReusableCell(withIdentifier: "ReusableRecipeIngredientCell", for: indexPath) as? RecipeIngredientCell {
                cell.setupIngredientCell(ingredient: myRecipe.ingredients[indexPath.row])
                return cell
            }
            return UITableViewCell()
        }
        
        func createInstructionCell(indexPath: IndexPath) -> UITableViewCell {
            guard let myRecipe = recipe else {
                return UITableViewCell()
            }
            
            if let cell = recipeDetailTableView.dequeueReusableCell(withIdentifier: "ReusableRecipeInstructionCell", for: indexPath) as? RecipeInstructionCell {
                cell.setupInstructionCell(instruction: myRecipe.instructions[indexPath.row])
                return cell
            }
            return UITableViewCell()
        }
    }

