//
//  AlertController.swift
//  Projet test
//
//  Created by DAUBERCIES on 30/03/2022.
//

import UIKit

extension UIViewController {
    
    /// Alert message of Network Error
     func alert(message: String) {
        let ac = UIAlertController(title: "Nous rencontrons une erreur", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
    }
}
