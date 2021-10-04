////
////  CoreDataManager.swift
////  Reciplease
////
////  Created by ROUX Maxime on 03/10/2021.
////
//
//import Foundation
//import CoreData
//
//final class CoreDataManager {
//
//    // MARK: - Properties
//
//    private let coreDataStack: CoreDataStack
//    private let managedObjectContext: NSManagedObjectContext
//
////    var favoriteRecipes: [favoriteRecipes] {
////        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
////        request.sortDescriptors = [NSSortDescriptor(key: "score", ascending: true)]
////        guard let favoriteRecipes = try? managedObjectContext.fetch(request) else { return [] }
////        return favoriteRecipes
////    }
//
//    // MARK: - Initializer
//
//    init(coreDataStack: CoreDataStack) {
//        self.coreDataStack = coreDataStack
//        self.managedObjectContext = coreDataStack.mainContext
//    }
//
//    // MARK: - Manage Task Entity
//
////    func manageFavorite(response: Bool) {
////        let recipe = RecipeApi(context: managedObjectContext)
////        recipe.favorite = response
////        coreDataStack.saveContext()
////    }
//
//
//
//
////    func deleteAllTasks() {
////        recipes.forEach { managedObjectContext.delete($0) }
////        coreDataStack.saveContext()
////    }
//
//}
//
////https://api.edamam.com/api/recipes/v2?type=public&q=chicken&app_id=057c28a7&app_key=b4db2359b9f2a14e2980106b8eadeffa
