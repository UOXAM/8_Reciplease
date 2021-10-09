//
//  RecipeService.swift
//  Reciplease
//
//  Created by ROUX Maxime on 03/10/2021.
//

import Foundation

extension RecipeService: UrlEncodable {}

final class RecipeService {

    
    // MARK: - Properties

    private let session: URLSession
    private var task: URLSessionDataTask?
    private let baseUrl: String = "https://api.edamam.com/api/recipes/v2"
    private let type = ("type", "public")
    private let appId = ("app_id", ApiEdamamConfig.app_id)
    private let appKey = ("app_key", ApiEdamamConfig.app_key)
    
    // MARK: - Initializer

    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    

    // MARK: - Network managment
    
//    func fetchRecipes(ingredients: String, callback: @escaping (Result<RecipeApi, NetworkError>) -> Void) {
    func fetchRecipes(ingredients: String, callback: @escaping (Result<RecipeApi, NetworkError>) -> Void) {
        guard let baseUrl = URL(string: baseUrl) else {return}
        let ingredientsParameter = ("q", ingredients)
        let parameters = [type, appId, appKey, ingredientsParameter]
        let url = encode(baseURL: baseUrl, parameters: parameters)

        #if DEBUG
        NetworkLogger(url: url).show()
        #endif
        session.dataTask(with: url, callback: callback)
    }
}
