//
//  URLEncodable.swift
//  Reciplease
//
//  Created by ROUX Maxime on 03/10/2021.
//

import Foundation

// MARK: - Protocol to encode URL

protocol UrlEncodable {
    func encode(baseURL: URL, parameters: [(String, Any)]?) -> URL
}

extension UrlEncodable {
    func encode(baseURL: URL, parameters: [(String, Any)]?) -> URL {
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false),
              let parameters = parameters,
              !parameters.isEmpty else {
            return baseURL
        }
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0, value: "\($1)") }
        guard let url = urlComponents.url else { return baseURL }
        return url
    }
}
