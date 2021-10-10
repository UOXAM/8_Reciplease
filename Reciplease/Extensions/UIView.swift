//
//  UIViewController+Formatting.swift
//  Reciplease
//
//  Created by ROUX Maxime on 10/10/2021.
//

import UIKit

// MARK: - Formatting

extension UIView {
    func borderFormatting(element: UIView) {
        element.layer.cornerRadius = 5
        element.layer.borderWidth = 0.5
        element.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
}

extension UIViewController {
    func buttonFormatting(button: UIButton) {
        button.layer.cornerRadius = 5
    }
}
