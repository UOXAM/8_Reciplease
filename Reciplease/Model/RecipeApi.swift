//
//  Recipe.swift
//  Reciplease
//
//  Created by ROUX Maxime on 03/10/2021.
//

import Foundation


// MARK: - Structure to decode .json response of API

// MARK: - RecipeApi
struct RecipeApi: Decodable {
    let from, to, count: Int
//    let links: WelcomeLinks
    let hits: [Hit]

    enum CodingKeys: String, CodingKey {
        case from, to, count
//        case links = "_links"
        case hits
    }
}

// MARK: - Hit
struct Hit: Decodable {
    let recipe: Recipe
//    let links: HitLinks

    enum CodingKeys: String, CodingKey {
        case recipe
//        case links = "_links"
    }
}

// MARK: - HitLinks
//struct HitLinks: Decodable {
//    let linksSelf: Next
//
//    enum CodingKeys: String, CodingKey {
//        case linksSelf = "self"
//    }
//}

// MARK: - Next
struct Next: Decodable {
//    let href: String
    let title: Title
}

enum Title: String, Codable {
    case nextPage = "Next page"
    case titleSelf = "Self"
}

// MARK: - Recipe
struct Recipe: Decodable {
    let uri: String
    let label: String
    let image: String
    let source: String
    let url: String
//    let shareAs: String
//    let yield: Int
//    let dietLabels: [DietLabel]
//    let healthLabels: [String]
//    let cautions: [Caution]
    let ingredientLines: [String]
    let ingredients: [Ingredient]
//    let calories, totalWeight: Double
    let totalTime: Int
//    let cuisineType: [String]
//    let mealType: [MealType]
//    let dishType: [DishType]
//    let totalNutrients, totalDaily: [String: Total]
//    let digest: [Digest]
}

//enum Caution: String, Decodable {
//    case fodmap = "FODMAP"
//    case soy = "Soy"
//    case sulfites = "Sulfites"
//}
//
//enum DietLabel: String, Decodable {
//    case balanced = "Balanced"
//    case highFiber = "High-Fiber"
//    case lowCarb = "Low-Carb"
//    case lowSodium = "Low-Sodium"
//}

// MARK: - Digest
//struct Digest: Decodable {
//    let label: Label
//    let tag: String
//    let schemaOrgTag: SchemaOrgTag?
//    let total: Double
//    let hasRDI: Bool
//    let daily: Double
//    let unit: Unit
//    let sub: [Digest]?
//}

//enum Label: String, Decodable {
//    case calcium = "Calcium"
//    case carbs = "Carbs"
//    case carbsNet = "Carbs (net)"
//    case cholesterol = "Cholesterol"
//    case energy = "Energy"
//    case fat = "Fat"
//    case fiber = "Fiber"
//    case folateEquivalentTotal = "Folate equivalent (total)"
//    case folateFood = "Folate (food)"
//    case folicAcid = "Folic acid"
//    case iron = "Iron"
//    case magnesium = "Magnesium"
//    case monounsaturated = "Monounsaturated"
//    case niacinB3 = "Niacin (B3)"
//    case phosphorus = "Phosphorus"
//    case polyunsaturated = "Polyunsaturated"
//    case potassium = "Potassium"
//    case protein = "Protein"
//    case riboflavinB2 = "Riboflavin (B2)"
//    case saturated = "Saturated"
//    case sodium = "Sodium"
//    case sugarAlcohols = "Sugar alcohols"
//    case sugars = "Sugars"
//    case sugarsAdded = "Sugars, added"
//    case thiaminB1 = "Thiamin (B1)"
//    case trans = "Trans"
//    case vitaminA = "Vitamin A"
//    case vitaminB12 = "Vitamin B12"
//    case vitaminB6 = "Vitamin B6"
//    case vitaminC = "Vitamin C"
//    case vitaminD = "Vitamin D"
//    case vitaminE = "Vitamin E"
//    case vitaminK = "Vitamin K"
//    case water = "Water"
//    case zinc = "Zinc"
//}

//enum SchemaOrgTag: String, Decodable {
//    case carbohydrateContent = "carbohydrateContent"
//    case cholesterolContent = "cholesterolContent"
//    case fatContent = "fatContent"
//    case fiberContent = "fiberContent"
//    case proteinContent = "proteinContent"
//    case saturatedFatContent = "saturatedFatContent"
//    case sodiumContent = "sodiumContent"
//    case sugarContent = "sugarContent"
//    case transFatContent = "transFatContent"
//}

//enum Unit: String, Decodable {
//    case empty = "%"
//    case g = "g"
//    case kcal = "kcal"
//    case mg = "mg"
//    case µg = "µg"
//}

//enum DishType: String, Decodable {
//    case condimentsAndSauces = "condiments and sauces"
//    case mainCourse = "main course"
//    case soup = "soup"
//    case starter = "starter"
//}

// MARK: - Ingredient
struct Ingredient: Decodable {
    let text: String
    let quantity: Double
    let measure: String?
    let food: String
    let weight: Double
    let foodCategory: String?
    let foodID: String
    let image: String?

    enum CodingKeys: String, CodingKey {
        case text, quantity, measure, food, weight, foodCategory
        case foodID = "foodId"
        case image
    }
}

//enum MealType: String, Decodable {
//    case brunch = "brunch"
//    case lunchDinner = "lunch/dinner"
//}

// MARK: - Total
//struct Total: Decodable {
//    let label: Label
//    let quantity: Double
//    let unit: Unit
//}
//
//// MARK: - WelcomeLinks
//struct WelcomeLinks: Decodable {
//    let next: Next
//}
