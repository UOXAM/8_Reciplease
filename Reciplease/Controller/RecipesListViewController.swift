//
//  recipesListViewController.swift
//  Reciplease
//
//  Created by ROUX Maxime on 01/10/2021.
//

import UIKit

class RecipesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    // MARK: - Outlets
    
//    @IBOutlet weak var navigationBar: UINavigationItem!
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var backNavigationItem: UINavigationItem!
    
    @IBAction func searchRecipesBiutton(_ sender: UIButton) {
    }
    @IBOutlet weak var recipesTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    private let recipeService = RecipeService()
//    private let ingredients = ["Chicken", "Apple"]
    private var recipeList: RecipeApi? = nil
    
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
            
//            CGPoint(x: mainView.frame.width / 2, y: mainView.frame.height / 2)
        // Do any additional setup after loading the view.
        
//        let backItem = UIBarButtonItem(title: "Custom", style: .plain, target: nil, action: nil)
//        navigationItem.backBarButtonItem = backItem
        
        // Launch Networkcall
        recipeService.fetchRecipes() { [weak self] result in
            DispatchQueue.main.async {
                self?.activityIndicator.startAnimating()

                switch result {
                    
                case .success(let recipeList):
                    self?.recipeList = recipeList
                    print (recipeList.hits[1].recipe.label)
                    print (recipeList.hits.count)
                    self?.recipesTableView.reloadData()

                case.failure(let error):
                    self?.showAlert(with: error.description)
                }
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//
//        // Launch Networkcall
//        recipeService.fetchRecipes() { [weak self] result in
//            DispatchQueue.main.async {
//                self?.activityIndicator.startAnimating()
//
//                switch result {
//
//                case .success(let recipeList):
//                    self?.recipeList = recipeList
//                    print (recipeList.hits[1].recipe.label)
//                    print (recipeList.hits.count)
//                    self?.recipesTableView.reloadData()
//
//                case.failure(let error):
//                    self?.showAlert(with: error.description)
//                }
//                self?.activityIndicator.stopAnimating()
//            }
//        }
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList?.hits.count ?? 20
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipesCell", for: indexPath)
        let recipe = recipeList?.hits[indexPath.row].recipe
        cell.textLabel?.text = recipe?.label
        cell.detailTextLabel?.text = recipe?.label

//        cell.textLabel?.text = recipe?.label

        return cell
    }

    @IBAction func actualizeTableViewButton(_ sender: UIButton) {
        recipesTableView.reloadData()
    }
    
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
