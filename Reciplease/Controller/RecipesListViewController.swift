//
//  recipesListViewController.swift
//  Reciplease
//
//  Created by ROUX Maxime on 01/10/2021.
//

import UIKit

class RecipesListViewController: UIViewController {
 
    
    // MARK: - Outlets
        
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var backNavigationItem: UINavigationItem!
    @IBOutlet weak var recipesTableView: UITableView!
    
    
    // MARK: - Properties
    
    var recipeList: RecipeApi?
    
    
//     MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TableViewCell take RecipeTableViewCell.xib as cell
        self.recipesTableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
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
        return 180
    }
    

    //     MARK: - Action

    

}


//// MARK: - UITableViewDataSource
//
//extension RecipesListViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    //    return coreDataManager?.tasks.count ?? 0
//        return rec
//    }
//
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let taskCell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
////        taskCell.textLabel?.text = coreDataManager?.tasks[indexPath.row].name
////        return taskCell
////    }
//}
//
//// MARK: - UITableViewDelegate
//
//extension RecipesListViewController: UITableViewDelegate {
////    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
////        let label = UILabel()
////        label.text = "Add some tasks in the list"
////        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
////        label.textAlignment = .center
////        label.textColor = .darkGray
////        return label
////    }
////
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
////        return coreDataManager?.tasks.isEmpty ?? true ? 200 : 0
//        return 200
//    }
//}
