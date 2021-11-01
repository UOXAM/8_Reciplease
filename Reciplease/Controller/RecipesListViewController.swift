//
//  recipesListViewController.swift
//  Reciplease
//
//  Created by ROUX Maxime on 01/10/2021.
//

import UIKit

class RecipesListViewController: UIViewController {
 
    
    // MARK: - Outlets
        
//    @IBOutlet weak var backNavigationItem: UINavigationItem!
    @IBOutlet weak var recipesTableView: UITableView!
    
    
    // MARK: - Properties
    
    var recipeList: RecipeApi?
    var recipeToPass: Recipe?
    
//     MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TableViewCell take RecipeTableViewCell.xib as cell
        self.recipesTableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    // TableViewCell take RecipeTableViewCell.xib as cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList?.hits.count ?? 0
    }
    
}


    // MARK: - UITableViewDataSource
    
extension RecipesListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RecipeTableViewCell {
            let recipe = recipeList?.hits[indexPath.row].recipe
            
            // Fill the title label with the name of recipe
            cell.titleLabel?.text = recipe?.label
            
            // Fill the image with the image of recipe
            let imageUrl = NSURL(string: recipe!.image)
            let imageData = NSData(contentsOf:imageUrl! as URL)

            if imageData != nil {
                cell.recipeImage?.image = UIImage(data:imageData! as Data)
            }

            // Formate list of ingredients and fill description label with these list
            var listOfIngredients: String = ""
            for i in 0...(recipe?.ingredients.count)!-1 {
                if listOfIngredients == "" {
                    listOfIngredients = String(recipe!.ingredients[i].food).firstUppercased
                } else {
                    listOfIngredients = "\(listOfIngredients), " + String( recipe!.ingredients[i].food).firstUppercased
                }
            }
            cell.descriptionLabel?.text = listOfIngredients

            return cell
            }

        return UITableViewCell()
    }
    
    // Height of cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    // Tap on cell -> segue
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipeList?.hits[indexPath.row].recipe
        recipeToPass = recipe
        performSegue(withIdentifier: "segueToRecipe", sender: nil)
        
    }
    
    
//     MARK: - Prepare Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRecipe" {
            let successVC = segue.destination as! RecipeViewController
            successVC.recipePassed = recipeToPass
        }
    }
    

    //     MARK: - Action


}
