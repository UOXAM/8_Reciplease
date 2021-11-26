//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by ROUX Maxime on 05/10/2021.
//

import UIKit
import Foundation

class RecipeTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreAndTimeView: UIView!
    
    var recipe: RecipeDetail? {
        didSet {
            
            // Fill the title label with the name of recipe
            titleLabel?.text = recipe?.label
            
            // Fill the image with the image of recipe
            let imageUrl = NSURL(string: recipe!.image!)
            let imageData = NSData(contentsOf:imageUrl! as URL)
            if imageData != nil {
                recipeImage?.image = UIImage(data:imageData! as Data)
            } else {
                recipeImage?.image = UIImage(imageLiteralResourceName: "recipeImageByDefault")
            }

            // Fill the duration if > 0
            if recipe?.duration == "0" || recipe?.duration == nil {
                scoreAndTimeView.isHidden = true
            } else {
                timeLabel?.text = "\(String(describing: (recipe?.duration)!)) min"
                scoreAndTimeView.isHidden = false
            }
            
            // Formate ingredients list
            var ingredients = ""
            guard recipe?.ingredientLabels != nil else { return }
            for i in 0...(recipe?.ingredientLabels?.count)!-1 {
                if ingredients == "" {
                    ingredients = (recipe?.ingredientLabels?[i])!
                } else {
                    ingredients = "\(ingredients), " + (recipe?.ingredientLabels?[i])!
                }
            }
            descriptionLabel?.text = ingredients
        }
    }
    
    // MARK: - Generic Functions

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        borderFormatting(element: scoreAndTimeView)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    
}
