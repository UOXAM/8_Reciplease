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
    
    
    //     MARK: - View Will Appear

    override func viewWillAppear(_ animated: Bool) {
        favoriteRecipesTableView.reloadData()
    }

    
    //     MARK: - Action

    @IBAction func deleteAll(_ sender: UIBarButtonItem) {
        guard (coreDataManager?.favoriteRecipes.count)! > 0 else {return}
        confirmAlert()
    }
    
    
    //     MARK: - Function

    func confirmAlert() {
        let alertController: UIAlertController = .init(title: "Do you want to delete all favories ?", message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [self]_ in
            coreDataManager?.deleteAllFavoriteRecipes()
            favoriteRecipesTableView.reloadData()
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
    
        present(alertController, animated: true)
    }
    
}


    // MARK: - TableView
    
extension FavoriteRecipesListViewController: UITableViewDataSource, UITableViewDelegate {
    
    // TableViewCell take RecipeTableViewCell.xib as cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager?.favoriteRecipes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RecipeTableViewCell {
            let recipe = coreDataManager?.favoriteRecipes[indexPath.row]
            cell.recipe = recipe

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
    
    // Footer in tableView
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "No recipes already saved as favorite..."
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }
    
    // Footer not visible if list is not empty
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return coreDataManager?.favoriteRecipes.isEmpty ?? true ? 350
        : 0
    }


    
//     MARK: - Prepare Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToFavoriteRecipe" {
            let successVC = segue.destination as! RecipeViewController
            successVC.recipePassed = favoriteRecipeToPass
        }
    }
}
