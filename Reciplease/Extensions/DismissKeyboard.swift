//
//  DismissKeyboard.swift
//  Reciplease
//
//  Created by ROUX Maxime on 06/12/2021.
//

import UIKit

// MARK: - Dismiss Keyboard

extension UIViewController {

    //Put this piece of code anywhere you like
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
