//
//  OurRecipesViewController.swift
//  OurRecipes
//
//  Created by Vanessa Hurla on 27/04/2023.
//

import Foundation
import UIKit

class OurRecipesViewController: UIViewController {
    
    @IBOutlet var recipesTableView: UITableView!
    
    var refreshControl = UIRefreshControl()
    var recipes = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        title = "All Recipes"
        
        setupTableView()
        loadData()
        
    }
    
    @objc func refresh() {
        loadData()
    }
    
    func loadData() {
        guard let url = URL(string: "https://api.jsonbin.io/v3/b/63cee902ace6f33a22c64d8a") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data,
                  error == nil else {
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(.serverDateFormat)
                let recipeRecord = try decoder.decode(RecipeRecord.self, from: data)
                self.orderArray(rawRecipes: recipeRecord.record.recipes)
                self.reloadData()
                
            } catch {
                print("error \(error)")
            }
        }
        task.resume()
    }
    
    func orderArray(rawRecipes: [Recipe]) {
        recipes = rawRecipes.sorted(by: { $0.date.compare($1.date) == .orderedDescending })
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.recipesTableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func presentRecipeDetails(recipe: Recipe) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "RecipeDetailViewController") as? RecipeDetailViewController else {
            return
        }
        viewController.recipe = recipe
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setupTableView() {
        let cellNib = UINib(nibName: "RecipeCell", bundle: nil)
        recipesTableView.register(cellNib, forCellReuseIdentifier: "ReusableRecipeCell")
        recipesTableView.dataSource = self
        recipesTableView.delegate = self
        recipesTableView.addSubview(refreshControl)
    }
}

// MARK: TABLEVIEW DATASOURCE

extension OurRecipesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableRecipeCell", for: indexPath) as? RecipeCell else {
            return UITableViewCell()
        }
        let recipe = recipes[indexPath.row]
        cell.setupCell(title: recipe.title, image: recipe.image, date: recipe.date)
        return cell
    }
}

// MARK: TABLEVIEW DELEGATE

extension OurRecipesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        presentRecipeDetails(recipe: recipe)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


