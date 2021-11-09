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
//    var recipePassed: Recipe?
    var recipePassed: RecipeDetail?
//    var favoriteRecipePassed: NSObject?
    var fromFavoriteList: Bool?

    
    //     MARK: - View Did Load

    override func viewDidLoad() {
        super .viewDidLoad()
        // If recipe is in CoreData base (same title, same id ?) then put favoriteButton.image == UIImage(systemName: "star.fill")
        print("*******",recipePassed?.label as Any)
        print("*******",recipePassed?.duration as Any)
        print("*******",recipePassed?.image as Any)
        print("*******",recipePassed?.url as Any)
        print("*******",recipePassed?.ingredientLines?.description as Any)

        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)

        titleLabel.text = recipePassed?.label
        timeLabel.text = recipePassed?.duration
        
        
        if self.coreDataManager?.isRecipeAlreadyFavorite(url: recipePassed!.url!) == true {
            favoriteButton.image = UIImage(systemName: "star.fill")
        }else{
            favoriteButton.image = UIImage(systemName: "star")
        }
        
        // Fill the image with the image of recipe
        let imageUrl = NSURL(string: recipePassed!.image!)
        let imageData = NSData(contentsOf:imageUrl! as URL)

        if imageData != nil {
            recipeImage.image = UIImage(data:imageData! as Data)
        }
    }
    
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        // lorsque je suis dans le détail d'une recette favorite et que je clique sur l'étoile -> elle est supprimée de la BDD
        // si je clique à nouveau sur l'étoile -> erreur : recipePassed = nil
        // Singleton Pattern
        if self.coreDataManager?.isRecipeAlreadyFavorite(url: recipePassed!.url!) == false {
                
            self.coreDataManager?.addFavoriteRecipe(recipe: recipePassed!)
            favoriteButton.image = UIImage(systemName: "star.fill")
            
        }else{
            self.coreDataManager?.deleteFavoriteRecipe(url: recipePassed!.url!, title: recipePassed!.label!)
            favoriteButton.image = UIImage(systemName: "star")
            guard fromFavoriteList == true else {return}
            
        }
    }
}

extension RecipeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return (recipePassed?.ingredientLines.count)!
        return (recipePassed?.ingredientLines?.count)!

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as? IngredientTableViewCell else {
            return UITableViewCell()
        }
//        cell.ingredientLabel.text = recipePassed?.ingredientLines[indexPath.row]
        cell.ingredientLabel.text = recipePassed?.ingredientLines?[indexPath.row]
        return cell
    }
    
    
    
    
}
