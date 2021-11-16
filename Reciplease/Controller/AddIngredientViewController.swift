//
//  ViewController.swift
//  Reciplease
//
//  Created by ROUX Maxime on 01/10/2021.
//

import UIKit
import CoreData

class AddIngredientViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var ingredientToAddTextField: UITextField!
    @IBOutlet weak var ingredientsListTextView: UITextView!
    @IBOutlet weak var searchForRecipesButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var addIngredientButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    // MARK: - Properties
    
    private var coreDataManager: CoreDataManager?
    var ingredientsListArray: [String] = []
    private let requestService = RequestService()
    private var recipeList: RecipeApi? = nil
    private var ingredientsListToNetworkcall: String = ""

    
    // MARK: - View Did Load

    override func viewDidLoad() {
        super .viewDidLoad()
        self.navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        buttonFormatting(button: clearButton)
        buttonFormatting(button: searchForRecipesButton)
        buttonFormatting(button: addIngredientButton)
    }
      
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
        
        activityIndicator.startAnimating()
        searchForRecipesButton.isHidden = true
        clearButton.isOpaque = true
        addIngredientButton.isOpaque = true
        
        // Launch Networkcall
        requestService.getData(ingredients: ingredientsListToNetworkcall) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let recipeList):
                    self?.recipeList = recipeList
                    guard recipeList.count! > 0 else {
                        self?.showAlert(with: "Aucune recette trouvée, essayez avec de nouveaux ingrédients")
                        return
                    }
                    self?.performSegue(withIdentifier: "segueToSuccess", sender: nil)

                case.failure(let error):
                    self?.showAlert(with: error.description)
                }
                self?.activityIndicator.stopAnimating()
                self?.searchForRecipesButton.isHidden = false
                self?.clearButton.isOpaque = false
                self?.addIngredientButton.isOpaque = false
            }
        }
    }
    
    // MARK: - Functions
    
    func addIngredientToList(_ ingredient: String) {
        // filter the array with the ingredient to add
        let filteredArray = ingredientsListArray.filter { $0.contains(ingredient) }
        // check if this ingredient is already in the array
        guard filteredArray.count < 1 else {
            // if YES : show alert and return
            self.showAlert(with: "Cet ingrédient semble déjà avoir été ajouté à la liste !")
            return
        }
            // if NO : add this ingredient to array
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

