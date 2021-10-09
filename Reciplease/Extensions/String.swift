//
//  String.swift
//  Reciplease
//
//  Created by ROUX Maxime on 05/10/2021.
//

import Foundation

extension String {
    
    // MARK: - Check if a string contains at least one element

    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespaces) == String() ? true : false
    }
}
    

    // MARK: - Capitalize first letter of first word

extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
}
