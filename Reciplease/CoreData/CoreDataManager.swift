//
//  CoreDataManager.swift
//  Reciplease
//
//  Created by ROUX Maxime on 03/10/2021.
//

import Foundation
import CoreData

final class CoreDataManager {

    // MARK: - Properties

    private let coreDataStack: CoreDataStack
    private let managedObjectContext: NSManagedObjectContext

    var favoriteRecipes: [FavoriteRecipe] {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        guard let favoriteRecipes = try? managedObjectContext.fetch(request) else { return [] }
        return favoriteRecipes
    }

    // MARK: - Initializer

    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }

    // MARK: - Manage Task Entity

    func addFavoriteRecipe(recipe: Recipe) {
//        func addFavorite(uri: String, title: String, ingredient: [String], duration: String, image: String) {

        let favoriteRecipe = FavoriteRecipe(context: managedObjectContext)
        favoriteRecipe.uri = recipe.uri
        favoriteRecipe.title = recipe.label
        
//        var arrayIngredients = ingredient
//        let data = NSData(bytes: &arrayIngredients, length: arrayIngredients.count)
//        recipe.ingredient = data
        
//        Test avec recipe.ingredient de type Transformable -> [String]
//        recipe.ingredient = ingredient
        favoriteRecipe.ingredient = recipe.ingredientLines
//        favoriteRecipe.ingredient = try? JSONEncoder().encode(recipe.ingredientLines)
        favoriteRecipe.duration = String(recipe.totalTime)
        favoriteRecipe.date = Date()
//        recipe.ingredient = ingredient
        favoriteRecipe.image = recipe.image
        coreDataStack.saveContext()
    }

    func deleteAllFavoriteRecipes() {
        favoriteRecipes.forEach { managedObjectContext.delete($0) }
        coreDataStack.saveContext()
    }
    
    func deleteFavoriteRecipe(uri: String, title: String) {
        let request : NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "uri == %@", uri)
        request.predicate = NSPredicate(format: "title == %@", title)

        if let entity = try? managedObjectContext.fetch(request) {
            entity.forEach { managedObjectContext.delete($0) }
        }
        coreDataStack.saveContext()
    }
    
    func isRecipeAlreadyFavorite(uri: String, title: String) -> Bool {
        let request : NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "uri == %@", uri)
        request.predicate = NSPredicate(format: "title == %@", title)

        guard let counter = try? managedObjectContext.count(for: request) else { return false }
        return counter == 0 ? false : true

    }

}
