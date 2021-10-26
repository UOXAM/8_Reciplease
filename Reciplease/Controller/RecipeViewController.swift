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
//    var recipeList: RecipeApi?
//    var indexPathToPass: IndexPath?
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
        
        // Verify if Recipe already saved (with Url)
        // If yes : favoriteButton.image = UIImage(systemName: "star.fill")
        // If No : favoriteButton.image = UIImage(systemName: "star")
        
        
    }
    
//    func recipeSaved() -> Bool {
//
//    }

    @IBAction func favoriteButton(_ sender: UIButton) {
                
        self.coreDataManager?.addFavorite(uri: recipePassed!.uri, title: recipePassed!.label, duration: String(recipePassed!.totalTime), image: recipePassed!.image, ingredient: recipePassed!.ingredientLines[0])
        favoriteButton.image = UIImage(systemName: "star.fill")
            
//        if favoriteButton.image == UIImage(systemName: "star") {
//            print("star")
//
//            self.coreDataManager?.addFavorite(uri: recipePassed!.uri, title: recipePassed!.label, ingredient: recipePassed!.ingredientLines[0].description, duration: String(recipePassed!.totalTime))
//
//
//
//
//
//            // Add Recipe to CoreData base
//            // Image became star.fill
//            favoriteButton.image = UIImage(systemName: "star.fill")
//
//        } else if favoriteButton.image == UIImage(systemName: "star.fill") {
//            print("star.fill")
//            // remove Recipe to CoreData base
//            // Image became star
//            favoriteButton.image = UIImage(systemName: "star")

//        }
        
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
