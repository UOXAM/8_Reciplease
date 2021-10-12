//
//  RecipeService.swift
//  Reciplease
//
//  Created by ROUX Maxime on 03/10/2021.
//


import Foundation

extension RequestService: UrlEncodable {}

final class RequestService {

    // MARK: - Properties
    // MARK: - Properties

    private let baseUrl: String = "https://api.edamam.com/api/recipes/v2"
    private let type = ("type", "public")
    private let appId = ("app_id", ApiEdamamConfig.app_id)
    private let appKey = ("app_key", ApiEdamamConfig.app_key)
    private let session: AlamofireSession

    // MARK: - Initializer

    init(session: AlamofireSession = EdamamSession()) {
        self.session = session
    }

    // MARK: - Management

    func getData(ingredients: String, callback: @escaping (Result<RecipeApi, NetworkError>) -> Void) {
        
        guard let baseUrl = URL(string: baseUrl) else {return}
        let ingredientsParameter = ("q", ingredients)
        let parameters = [type, appId, appKey, ingredientsParameter]
        let url = encode(baseURL: baseUrl, parameters: parameters)
        
        #if DEBUG
        NetworkLogger(url: url).show()
        #endif
        
        session.request(url: url) { dataResponse in
            guard let data = dataResponse.data else {
                callback(.failure(.noData))
                return
            }
            guard dataResponse.response?.statusCode == 200 else {
                callback(.failure(.invalidResponse))
                return
            }
            guard let dataDecoded = try? JSONDecoder().decode(RecipeApi.self, from: data) else {
                callback(.failure(.undecodableData))
                return
            }
            callback(.success(dataDecoded))
        }
    }
}
