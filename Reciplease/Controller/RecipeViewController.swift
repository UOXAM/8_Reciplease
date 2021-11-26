//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by ROUX Maxime on 10/10/2021.
//

import UIKit

class RecipeViewController: UIViewController {

    
    // MARK: - Outlets

    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var scoreAndTimeView: UIView!
    
    
    
    // MARK: - Properties

    private var coreDataManager: CoreDataManager?
    var recipePassed: RecipeDetail?
    
    
    
    //     MARK: - View Did Load

    override func viewDidLoad() {
        super .viewDidLoad()
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
        view.borderFormatting(element: timeView)
//        print(recipePassed?.ingredientLabels)
//        print(coreDataManager?.favoriteRecipes[0])
    }

    
    //     MARK: - View Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        // If recipe is in CoreData base (same title, same id ?) then put favoriteButton.image == UIImage(systemName: "star.fill")
        if self.coreDataManager?.isRecipeAlreadyFavorite(url: recipePassed!.url!) == true {
            favoriteButton.image = UIImage(systemName: "star.fill")
        }else{
            favoriteButton.image = UIImage(systemName: "star")
        }
        
        // Fill infos of recipe
        titleLabel.text = recipePassed?.label
        
        // Fill the duration if != 0 or nil
        if recipePassed?.duration == "0" || recipePassed?.duration == nil {
            scoreAndTimeView.isHidden = true
        } else {
            timeLabel?.text = "\(String(describing: (recipePassed?.duration)!)) min"
            scoreAndTimeView.isHidden = false
        }

        // Fill the image with the image of recipe
        let imageUrl = NSURL(string: recipePassed!.image!)
        let imageData = NSData(contentsOf:imageUrl! as URL)
        recipeImage.image = UIImage(data:imageData! as Data)

//        if imageData != nil {
//            recipeImage.image = UIImage(data:imageData! as Data)
//        } else {
//            recipeImage.image = UIImage(imageLiteralResourceName: "recipeImageByDefault")
//        }
    }
    
    
    //     MARK: - Actions

    @IBAction func favoriteButton(_ sender: UIButton) {
        // if recipe already saved as favorite : delete from favorite
        if self.coreDataManager?.isRecipeAlreadyFavorite(url: recipePassed!.url!) == true {

            self.coreDataManager?.deleteFavoriteRecipe(url: recipePassed!.url!, title: recipePassed!.label!)
            favoriteButton.image = UIImage(systemName: "star")
            
            // if the active tab is Favorite tab : came back to previous screen (favorite list)
            guard tabBarController?.selectedIndex == 1 else {return}

            self.navigationController?.popToRootViewController(animated: true)
        
        // if recipe not already saved as favorite : add to favorite
        } else {
            self.coreDataManager?.addFavoriteRecipe(recipe: recipePassed!)
            favoriteButton.image = UIImage(systemName: "star.fill")
        }
    }
}


//     MARK: - TableView

extension RecipeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (recipePassed?.ingredientLines?.count)!

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as? IngredientTableViewCell else {
            return UITableViewCell()
        }
        cell.ingredientLabel.text = recipePassed?.ingredientLines?[indexPath.row]
        return cell
    }
}
