//
//  CoreDataManagerTests.swift
//  RecipleaseTests
//
//  Created by ROUX Maxime on 15/11/2021.
//
@testable import Reciplease
import XCTest

final class CoreDataManagerTests: XCTestCase {

    // MARK: - Properties

    var coreDataStack: MockCoreDataStack!
    var coreDataManager: CoreDataManager!

    //MARK: - Tests Life Cycle

    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }

    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
        coreDataStack = nil
    }

    // MARK: - Tests

    // Test of function addFavoriteRecipe
    func testAddRecipeToFavorite_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() {
        // Create 1 recipe and Save it in DataBase
        let firstFakeRecipe = FakeRecipe()
        coreDataManager.addFavoriteRecipe(recipe: firstFakeRecipe)
        // Database is not empty, Contains 1 element and Recipe saved label is same as the one to save
        XCTAssertTrue(!coreDataManager.favoriteRecipes.isEmpty)
        XCTAssertTrue(coreDataManager.favoriteRecipes.count == 1)
        XCTAssertTrue(coreDataManager.favoriteRecipes[0].label! == "Lemon Sorbet")
    }
    
    // Test of function deleteAllFavoriteRecipes
    func testDeleteAllFavoriteRecipes_WhenAnEntityIsCreated_ThenShouldBeCorrectlyDeleted() {
        let firstFakeRecipe = FakeRecipe()
        let secondFakeRecipe = FakeRecipe()
        secondFakeRecipe.url =  "https//www.edamam.com"
        secondFakeRecipe.label = "Lemon Curd"
        coreDataManager.addFavoriteRecipe(recipe: firstFakeRecipe)
        coreDataManager.addFavoriteRecipe(recipe: secondFakeRecipe)
        XCTAssertTrue(coreDataManager.favoriteRecipes.count == 2)

        coreDataManager.deleteAllFavoriteRecipes()
        XCTAssertTrue(coreDataManager.favoriteRecipes.isEmpty)
    }
    
    // Test of function deleteFavoriteRecipe
    func testDeleteRecipeFromFavorites_WhenAnEntityIsCreated_ThenRecipeShouldBeCorrectlyDeleted() {
        // Create 2 different recipes, Saved them and Verify there are 2 recipes in DataBase
        let firstFakeRecipe = FakeRecipe()
        let secondFakeRecipe = FakeRecipe()
        secondFakeRecipe.url =  "https//www.edamam.com"
        secondFakeRecipe.label = "Lemon Curd"
        coreDataManager.addFavoriteRecipe(recipe: firstFakeRecipe)
        coreDataManager.addFavoriteRecipe(recipe: secondFakeRecipe)
        XCTAssertTrue(coreDataManager.favoriteRecipes.count == 2)
        
        // Delete the first recipe
        coreDataManager.deleteFavoriteRecipe(url: firstFakeRecipe.url!, title: firstFakeRecipe.label!)
        
        // Verify there is now 1 recipe in DataBase and its label is the same as secondFakeRecipe label
        XCTAssertTrue(coreDataManager.favoriteRecipes.count == 1)
        XCTAssertEqual(coreDataManager.favoriteRecipes[0].label, secondFakeRecipe.label)
    }
    
    // Test of function isRecipeAlreadyFavorite
    func testIfRecipeAlreadyInFavorite_WhenRecipeSavedInDataBase_ThenRecipeSouldBeFoundInDataBase() {
        // Create 1 recipe and Save it in DataBase
        let firstFakeRecipe = FakeRecipe()
        coreDataManager.addFavoriteRecipe(recipe: firstFakeRecipe)
        
        // Verify recipe is already saved (recipe Url exist in database)
        XCTAssertTrue(coreDataManager.isRecipeAlreadyFavorite(url: firstFakeRecipe.url!))
    }
    
    // Test of function isRecipeAlreadyFavorite
    func testIfRecipeAlreadyInFavorite_WhenRecipeNotSavedInDataBase_ThenRecipeSouldNotBeFoundInDataBase() {
        // Create 1 recipe
        let firstFakeRecipe = FakeRecipe()
        
        // Verify recipe does not exist in database (recipe Url does not exist in database)
        XCTAssertFalse(coreDataManager.isRecipeAlreadyFavorite(url: firstFakeRecipe.url!))
    }
    
}
