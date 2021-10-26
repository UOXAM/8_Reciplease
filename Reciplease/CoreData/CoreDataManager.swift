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

    func addFavorite(uri: String, title: String, duration: String, image: String, ingredient: String) {
//        func addFavorite(uri: String, title: String, ingredient: [String], duration: String, image: String) {

        let recipe = FavoriteRecipe(context: managedObjectContext)
        recipe.uri = uri
        recipe.title = title
//        recipe.ingredient = ingredient as NSObject
        recipe.duration = duration
        recipe.date = Date()
        recipe.ingredient = ingredient
        recipe.image = image
        coreDataStack.saveContext()
    }

    func removeFavorite() {
        favoriteRecipes.forEach { managedObjectContext.delete($0) }
        coreDataStack.saveContext()
    }


}
