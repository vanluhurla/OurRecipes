//
//  Recipe.swift
//  OurRecipes
//
//  Created by Vanessa Hurla on 27/04/2023.
//

import Foundation

struct RecipeRecord: Codable {
    let record: RecipeList
}

struct RecipeList: Codable {
    let recipes: [Recipe]
}

struct Recipe: Codable {
    let image: String
    let title: String
    let date: Date
    let ingredients: [String]
    let instructions: [String]
}
