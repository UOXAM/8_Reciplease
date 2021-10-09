//
//  UIImageView.swift
//  Reciplease
//
//  Created by ROUX Maxime on 09/10/2021.
//

import UIKit

// MARK: - Load image from url

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
