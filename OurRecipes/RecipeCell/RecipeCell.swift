//
//  RecipeCell.swift
//  OurRecipes
//
//  Created by Vanessa Hurla on 27/04/2023.
//

import Foundation
import UIKit

class RecipeCell: UITableViewCell {
    
    @IBOutlet var recipeImageView: UIImageView!
    @IBOutlet var recipeTitleLabel: UILabel!    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet var containerView: UIView!
    
    
    func setupCell(title: String, image: String, date: Date) {
        loadingIndicator.startAnimating()
        loadingIndicator.hidesWhenStopped = true
        recipeTitleLabel.text = title
        dateLabel.text = DateFormatter.readableDateFormat.string(from: date)
        recipeImageView.downloadImage(from: image) { [weak self] in
            self?.loadingIndicator.stopAnimating()
        }
        recipeImageView.layer.cornerRadius = 40.0
        recipeImageView.layer.masksToBounds = true
        contentView.backgroundColor = .clear
        containerView.layer.cornerRadius = 20.0
        containerView.layer.masksToBounds = true
    }
}
    

