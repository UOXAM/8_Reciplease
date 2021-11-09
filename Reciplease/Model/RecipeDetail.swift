//
//  RecipeDetail.swift
//  Reciplease
//
//  Created by ROUX Maxime on 28/10/2021.
//

import Foundation

protocol RecipeDetail {
    
    var label: String? { get set }
    var image: String? { get set }
    var ingredientLines: [String]? { get set }
    var duration: String? { get set }
    var url: String? { get set }

}

extension FavoriteRecipe: RecipeDetail {}

