//
//  FavoriteRecipesListViewController.swift
//  Reciplease
//
//  Created by ROUX Maxime on 21/10/2021.
//

import UIKit

class FavoriteRecipesListViewController: UIViewController {
 
    
    // MARK: - Outlets
        
    @IBOutlet weak var favoriteRecipesTableView: UITableView!
    
    
    // MARK: - Properties
    
//    var recipeList: RecipeApi?
//    var recipeToPass: Recipe?
    private var coreDataManager: CoreDataManager?
    var favoriteRecipeToPass: RecipeDetail?
    

    
//     MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
        
        // TableViewCell take RecipeTableViewCell.xib as cell
        self.favoriteRecipesTableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    
    @IBAction func deleteButton(_ sender: UIButton) {
        coreDataManager?.deleteAllFavoriteRecipes()
        favoriteRecipesTableView.reloadData()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteRecipesTableView.reloadData()
    }
}


    // MARK: - UITableViewDataSource
    
extension FavoriteRecipesListViewController: UITableViewDataSource, UITableViewDelegate {
    
    // TableViewCell take RecipeTableViewCell.xib as cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager?.favoriteRecipes.count ?? 0
    }
    
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RecipeTableViewCell {
            let recipe = coreDataManager?.favoriteRecipes[indexPath.row]
            
            // Fill the title label with the name of recipe
            cell.titleLabel?.text = recipe?.label
            
            // Fill the image with the image of recipe
            let imageUrl = NSURL(string: (recipe?.image)!)
            let imageData = NSData(contentsOf:imageUrl! as URL)
            if imageData != nil {
                cell.recipeImage?.image = UIImage(data:imageData! as Data)
                
            }
            
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
        let recipe: RecipeDetail = (coreDataManager?.favoriteRecipes[indexPath.row])!
        favoriteRecipeToPass = recipe
        performSegue(withIdentifier: "segueToFavoriteRecipe", sender: nil)
    }
    
    
//     MARK: - Prepare Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToFavoriteRecipe" {
            let successVC = segue.destination as! RecipeViewController
            successVC.recipePassed = favoriteRecipeToPass
            successVC.fromFavoriteList = true
        }
    }
    
    
    
    
}
