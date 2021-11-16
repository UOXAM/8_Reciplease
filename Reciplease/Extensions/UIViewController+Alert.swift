//
//  UIViewController+Alert.swift
//  Reciplease
//
//  Created by ROUX Maxime on 04/10/2021.
//

import UIKit

// MARK: - Show generic alert

extension UIViewController {
    func showAlert(with message: String) {
        let alertController: UIAlertController = .init(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
    
//    func confirmAlert(with message: String) {
//        let alertController: UIAlertController = .init(title: message, message: "", preferredStyle: .alert)
//        alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: ))
//        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
//
//        present(alertController, animated: true)
//    }
//
//    func displayTaskAlert(handlerTaskName: @escaping (String?) -> Void) {
//        let alertController = UIAlertController(title: "OK ?", message: "", preferredStyle: .alert)
//
//        let addAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
//            guard let
//                    textField = alertController.textFields else { return }
//            handlerTaskName(textField[0].text)
//        })
//        alertController.addAction(addAction)
//        present(alertController, animated: true, completion: nil)
//    }
    
}
