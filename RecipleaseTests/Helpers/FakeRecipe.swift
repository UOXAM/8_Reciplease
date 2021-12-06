//
//  FakeRecipe.swift
//  RecipleaseTests
//
//  Created by ROUX Maxime on 18/11/2021.
//

import Foundation
@testable import Reciplease

class FakeRecipe: RecipeDetail {
    
    var ingredientLabels: [String]? = ["Sugar", "Lemon", "Lemon juice"]
    
    var label: String? = "Lemon Sorbet"
    
    var image: String? = "https://www.edamam.com/web-img/78e/78ef0e463d0aadbf2caf7b6237cd5f12.jpg"
    
    var ingredientLines: [String]? = ["500.0g caster sugar", "1 lemon , unwaxed, zested", "250 ml lemon juice (6-8 lemons)"]
    
    var duration: String? = "0.0"
    
    var url: String? = "http://www.bbcgoodfood.com/recipes/4583/"

}
