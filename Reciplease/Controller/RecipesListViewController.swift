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
    var recipeToPass: RecipeDetail?
    var isLoading = false
//    var fromResults = 0
//    var toResults = 20
    private let requestService = RequestService()

    
//     MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TableViewCell take RecipeTableViewCell.xib as cell
        self.recipesTableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }
    
    // TableViewCell take RecipeTableViewCell.xib as cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList?.hits?.count ?? 0
    }
    
    
}


    // MARK: - UITableViewDataSource
    
extension RecipesListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RecipeTableViewCell {
            let recipe = recipeList?.hits?[indexPath.row].recipe
            
            // Fill the title label with the name of recipe
            cell.titleLabel?.text = recipe?.label
            
            // Fill the image with the image of recipe
            let imageUrl = NSURL(string: recipe!.image!)
            let imageData = NSData(contentsOf:imageUrl! as URL)

            if imageData != nil {
                cell.recipeImage?.image = UIImage(data:imageData! as Data)
            }

            // Formate list of ingredients and fill description label with these list
            var listOfIngredients: String = ""
            for i in 0...(recipe?.ingredients?.count)!-1 {
                if listOfIngredients == "" {
                    listOfIngredients = (String?((recipe?.ingredients?[i].food)!)!.firstUppercased)!
                } else {
                    listOfIngredients = "\(listOfIngredients), " + (String?((recipe?.ingredients?[i].food)!)!.firstUppercased)!
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
        var recipe = recipeList?.hits?[indexPath.row].recipe
        recipe!.duration = String((recipe?.totalTime)!)
        recipeToPass = recipe
        performSegue(withIdentifier: "segueToRecipe", sender: nil)
    }
    
    
//     MARK: - Prepare Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRecipe" {
            let successVC = segue.destination as! RecipeViewController
            successVC.recipePassed = recipeToPass
            successVC.fromFavoriteList = false
        }
    }


    //     MARK: - Action

    // ***** S'il reste des nouvelles recettes à afficher (si lien _links.next.href) alors
    // -> relancer une requête réseau lorsqu'on scroll

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard recipeList?.links?.next?.href != nil && recipeList?.links?.next?.href != "" else { return }

        guard isLoading == false else { return }
        isLoading = true
        
        requestService.getNextData(url: (recipeList?.links?.next?.href)!, callback: { [weak self] result in
            self?.isLoading = false

            DispatchQueue.main.async {

                switch result {
                    
                case .success(let recipeListToAdd):
                    self?.recipeList?.hits?.append(contentsOf: (recipeListToAdd.hits)!)
                    self?.recipesTableView.reloadData()

                    guard recipeListToAdd.links?.next?.href != nil else {
                        self?.recipeList?.links?.next?.href = ""
                        return}
                    self?.recipeList?.links?.next?.href = recipeListToAdd.links?.next?.href
                    
                case.failure(let error):
                    self?.showAlert(with: error.description)
                }
                
//                self?.activityIndicator.stopAnimating()
//                self?.searchForRecipesButton.isHidden = false
//                self?.clearButton.isOpaque = false
//                self?.addIngredientButton.isOpaque = false
            }
            
        })
        
        
        
        
        
        
        
        
        // ***** Lancer appel réseau en utilisant l'URL du retour API précédant _links.next.href ou avec fromResults et toResults
        // Comment réussir à accéder dans API ? _links ?
        
        // ***** Ajouter les résultats à la suite de recipeList
        
        // ***** Changer _links.next.href par le lien du nouvel appel réseau
        
        // ***** S'il n'y a pas de
    }
        
}
