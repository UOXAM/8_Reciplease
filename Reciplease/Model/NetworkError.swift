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
        case .noData, .invalidResponse, .undecodableData:
            return "The service is momentarily unavailable"
        }
    }
}
