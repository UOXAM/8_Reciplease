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
        // Trier du plus recent au plus ancien
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        guard let favoriteRecipes = try? managedObjectContext.fetch(request) else { return [] }
        return favoriteRecipes
    }

    // MARK: - Initializer

    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }

    // MARK: - Manage Task Entity

    func addFavoriteRecipe(recipe: RecipeDetail) {
//        func addFavorite(uri: String, title: String, ingredient: [String], duration: String, image: String) {

        let favoriteRecipe = FavoriteRecipe(context: managedObjectContext)
        favoriteRecipe.url = recipe.url
        favoriteRecipe.label = recipe.label
//        Recipe.ingredient de type Transformable -> [String]
        favoriteRecipe.ingredientLines = recipe.ingredientLines
        favoriteRecipe.duration = recipe.duration
        favoriteRecipe.date = Date()
        favoriteRecipe.image = recipe.image
        coreDataStack.saveContext()
    }

    func deleteAllFavoriteRecipes() {
        favoriteRecipes.forEach { managedObjectContext.delete($0) }
        coreDataStack.saveContext()
    }
    
    func deleteFavoriteRecipe(url: String, title: String) {
        let request : NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "url == %@", url)
//        request.predicate = NSPredicate(format: "title == %@", title)

        if let entity = try? managedObjectContext.fetch(request) {
            entity.forEach { managedObjectContext.delete($0) }
        }
        coreDataStack.saveContext()
    }
    
    func isRecipeAlreadyFavorite(url: String) -> Bool {
        let request : NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "url == %@", url)
//        request.predicate = NSPredicate(format: "title == %@", title)

        guard let counter = try? managedObjectContext.count(for: request) else { return false }
        return counter == 0 ? false : true
    }

}
