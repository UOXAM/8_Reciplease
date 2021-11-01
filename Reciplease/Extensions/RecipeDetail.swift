//
//  RecipeDetail.swift
//  Reciplease
//
//  Created by ROUX Maxime on 28/10/2021.
//

import Foundation

protocol RecipeDetail {
    
    var ingredients: [String] { get set }
    var title: String { get set }
    var time: String { get set }
    var image: String { get set }
    
}
