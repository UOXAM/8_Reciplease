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
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreAndTimeView: UIView!
    
    
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
