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

//    func testAddTaskMethods_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() {
//        coreDataManager.addFavoriteRecipe(recipe: <#T##RecipeDetail#>)
//        XCTAssertTrue(!coreDataManager.tasks.isEmpty)
//        XCTAssertTrue(coreDataManager.tasks.count == 1)
//        XCTAssertTrue(coreDataManager.tasks[0].name! == "My Task")
//    }
//
//    func testDeleteAllTasksMethod_WhenAnEntityIsCreated_ThenShouldBeCorrectlyDeleted() {
//        coreDataManager.createTask(name: "My Task")
//        coreDataManager.deleteAllTasks()
//        XCTAssertTrue(coreDataManager.tasks.isEmpty)
//    }
}
