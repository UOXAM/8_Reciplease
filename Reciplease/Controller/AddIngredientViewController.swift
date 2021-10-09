//
//  ViewController.swift
//  Reciplease
//
//  Created by ROUX Maxime on 01/10/2021.
//

import UIKit

class AddIngredientViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var ingredientToAddTextField: UITextField!
    @IBOutlet weak var ingredientsListTextView: UITextView!
    @IBOutlet weak var searchForRecipesButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var addIngredientButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    // MARK: - Properties

    var ingredientsListArray: [String] = []
    private let recipeService = RecipeService()
    private var recipeList: RecipeApi? = nil
    private var ingredientsListToNetworkcall: String = ""

    
    // MARK: - Actions

    @IBAction func clearButton(_ sender: UIButton) {
        // list and textView became empty
        ingredientsListArray = []
        ingredientsListToNetworkcall = ""
        ingredientsListTextView.text = ""
    }
    
    @IBAction func addIngredientButton(_ sender: UIButton) {
        // verify an ingredient is entered
        guard let ingredient = ingredientToAddTextField.text, !ingredient.isBlank, ingredient != "" else { return }
        // verify it is not just a number
        guard Double(ingredient) == nil else {
            showAlert(with: "Cela ne semble pas être un ingrédient mais un nombre !")
            return
        }
        // add ingredient to the list array
        addIngredientToList(ingredient)
        // add ingredient to the list formatted to networkcall
        addIngredientToNetworkcall(ingredient)
        // textview became empty, ready to enter a new ingredient
        ingredientToAddTextField.text = ""
        // show in textView the list
        showAllIngredients()
    }

    @IBAction func searchForRecipesButton(_ sender: UIButton) {
        // If the list of ingredients is not empty
        guard ingredientsListArray.count > 0 else {
            showAlert(with: "La liste d'ingrédients est vide! Veuillez la compléter avant de rechercher des recettes.")
            return
        }
        print (ingredientsListArray)
        print(ingredientsListToNetworkcall)
        
        // Launch Networkcall
        recipeService.fetchRecipes(ingredients: ingredientsListToNetworkcall) { [weak self] result in

            DispatchQueue.main.async {
                self?.activityIndicator.startAnimating()
                self?.searchForRecipesButton.isHidden = true

                switch result {
                    
                case .success(let recipeList):
                    self?.recipeList = recipeList
                    guard recipeList.count > 0 else {
                        self?.showAlert(with: "Aucune recette trouvée, essayez avec de nouveaux ingrédients")
                        return
                    }
                    self?.performSegue(withIdentifier: "segueToSuccess", sender: nil)

                case.failure(let error):
                    self?.showAlert(with: error.description)
                }
                
                self?.activityIndicator.stopAnimating()
                self?.searchForRecipesButton.isHidden = false

            }
        }
    }
    
    // MARK: - Functions
    
    func addIngredientToList(_ ingredient: String) {
        // add ingredient to the list array
        ingredientsListArray.append(ingredient)
    }
    
    func addIngredientToNetworkcall(_ ingredient: String) {
        // add ingredient to the list formatted for the Networkcall
        if ingredientsListToNetworkcall == "" {
            ingredientsListToNetworkcall = ingredient
        } else {
            ingredientsListToNetworkcall = "\(ingredientsListToNetworkcall),\(ingredient)"
        }
    }
    
    func showAllIngredients() {
        var ingredients: String = ""
        // list ingredients of the array with formatting
        for i in 0...ingredientsListArray.count-1 {
            if ingredients == "" {
                ingredients = "- \(ingredientsListArray[i].firstUppercased)"
            } else {
                ingredients = "\(ingredients)\n- \(ingredientsListArray[i].firstUppercased)"
            }
        }
        // show this list in the textView
        ingredientsListTextView.text = ingredients
    }
    

    // MARK: - Prepare Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToSuccess" {
            let successVC = segue.destination as! RecipesListViewController
            successVC.recipeList = recipeList
        }
    }

}

