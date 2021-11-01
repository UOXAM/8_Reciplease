//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by ROUX Maxime on 10/10/2021.
//

import UIKit

class RecipeViewController: UIViewController  {

    
    // MARK: - Outlets

    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var ingredientCell: UITableViewCell!
    
    
    // MARK: - Properties

    private var coreDataManager: CoreDataManager?
    var recipePassed: Recipe?
    var favoriteRecipePassed: NSObject?
    

    
    //     MARK: - View Did Load

    override func viewDidLoad() {
        super .viewDidLoad()
        // If recipe is in CoreData base (same title, same id ?) then put favoriteButton.image == UIImage(systemName: "star.fill")
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)

        titleLabel.text = recipePassed?.label
        timeLabel.text = recipePassed?.totalTime.description
        
        
        if self.coreDataManager?.isRecipeAlreadyFavorite(uri: recipePassed!.uri, title: recipePassed!.label) == true {
            favoriteButton.image = UIImage(systemName: "star.fill")
        }else{
            favoriteButton.image = UIImage(systemName: "star")
        }
        
        // Fill the image with the image of recipe
        let imageUrl = NSURL(string: recipePassed!.image)
        let imageData = NSData(contentsOf:imageUrl! as URL)

        if imageData != nil {
            recipeImage.image = UIImage(data:imageData! as Data)
        }

    }
    
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        
        if self.coreDataManager?.isRecipeAlreadyFavorite(uri: recipePassed!.uri, title: recipePassed!.label) == false {
                
            self.coreDataManager?.addFavoriteRecipe(recipe: recipePassed!)
            favoriteButton.image = UIImage(systemName: "star.fill")
            
        }else{
            self.coreDataManager?.deleteFavoriteRecipe(uri: recipePassed!.uri, title: recipePassed!.label)
            favoriteButton.image = UIImage(systemName: "star")
        }
    }
    
    
    
}

extension RecipeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (recipePassed?.ingredientLines.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as? IngredientTableViewCell else {
            return UITableViewCell()
        }
        cell.ingredientLabel.text = recipePassed?.ingredientLines[indexPath.row]
        
        return cell
    }
    
    
    
    
}
