//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by ROUX Maxime on 10/10/2021.
//

import UIKit

class RecipeViewController: UIViewController  {

    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    var recipeList: RecipeApi?
    
    override func viewDidLoad() {
        super .viewDidLoad()
        // If recipe is in CoreData base (same title, same id ?) then put favoriteButton.image == UIImage(systemName: "star.fill")
    }

    @IBAction func favoriteButton(_ sender: UIButton) {
        
        if favoriteButton.image == UIImage(systemName: "star") {
            print("star")
            // Add Recipe to CoreData base
            // Image became star.fill
            favoriteButton.image = UIImage(systemName: "star.fill")
            
        } else if favoriteButton.image == UIImage(systemName: "star.fill") {
            print("star.fill")
            // remove Recipe to CoreData base
            // Image became star
            favoriteButton.image = UIImage(systemName: "star")

        }
    }
    
}
