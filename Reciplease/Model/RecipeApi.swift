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
    let from, to, count: Int?
    var links: Links?
    var hits: [Hit]?

    enum CodingKeys: String, CodingKey {
        case from, to, count
        case links = "_links"
        case hits
    }
}

// MARK: - Links
struct Links: Decodable {
    var next: Next?
}


// MARK: - Hit
struct Hit: Decodable {
    let recipe: Recipe?
    let links: HitLinks?

    enum CodingKeys: String, CodingKey {
        case recipe
        case links = "_links"
    }
}

struct HitLinks: Decodable {
    let linksSelf: Next?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

// MARK: - Next
struct Next: Decodable {
    var href: String?
//    let title: Title?
}

//enum Title: String, Codable {
//    case nextPage = "Next page"
//    case titleSelf = "Self"
//}

// MARK: - Recipe
struct Recipe: Decodable, RecipeDetail {
    var label: String?
    var image: String?
//    let source: String?
    var url: String?
    var ingredientLines: [String]?
    var ingredients: [Ingredient]?
    var totalTime: Int?
    var duration: String?
}

//struct Recipe: Decodable {
//    let title: String
//    let imageUrl: String
//    let url: String
//    let duration: Int
//    let ingredients: [Ingredient]
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: RecipeApi.self)
//        let recipe =  try container.nestedContainer(keyedBy: RecipeApi.self, forKey: .recipe)
//        let title = try recipe.decode(String.self, forKey: .recipe)
//    }
//}

// MARK: - Ingredient
struct Ingredient: Decodable {
//    let text: String?
//    let quantity: Double?
//    let measure: String?
    let food: String?
//    let weight: Double?
//    let foodCategory: String?
//    let foodID: String?
//    let image: String?

    enum CodingKeys: String, CodingKey {
        case food
//            text, quantity, measure, food, weight, foodCategory
//        case foodID = "foodId"
//        case image
    }
}
