//
//  UIViewController+Extensions.swift
//  Headline
//
//  Created by Hugo Pivaral on 9/07/22.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, completion: ( (() -> Void))? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(okAction)
        
        present(alertController, animated: true) {
            completion?()
        }
    }
}
