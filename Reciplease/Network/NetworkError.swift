//
//  NetworkError.swift
//  Reciplease
//
//  Created by ROUX Maxime on 03/10/2021.
//


import Foundation

// MARK: - Network Errors

enum NetworkError:  Error {
    case noData, invalidResponse, undecodableData
}

extension NetworkError: CustomStringConvertible {
    var description: String {
        switch self {
        case .noData:
            return "No Data"
        case .invalidResponse:
            return "Invalid response"
        case .undecodableData:
            return "Undecodable data"
        }
    }
}
