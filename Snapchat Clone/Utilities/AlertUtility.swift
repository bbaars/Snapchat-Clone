//
//  AlertUtility.swift
//  Snapchat Clone
//
//  Created by Brandon Baars on 3/26/19.
//  Copyright © 2019 Brandon Baars. All rights reserved.
//

import UIKit

class AlertUtility {
    
    
    /// Get an alert controller with the specified Title and Message
    ///
    /// - Parameters:
    ///   - title: The title of the alert controller
    ///   - message: The message to be displayed in the controller
    /// - Returns: The UIAlertController
    static func getAlertController(withTitle title: String, andMessage message: String) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
    
    
    /// Get a default alert controller with an 'Okay' button
    ///
    /// - Parameters:
    ///   - title: The title of the alert controller
    ///   - message: The message to be displayed in the controller
    /// - Returns: The UIAlertController with an Okay button.
    static func getOkayAlertController(withTitle title: String, withMessage message: String) -> UIAlertController {
        let alertController = getAlertController(withTitle: title, andMessage: message)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default))
        
        return alertController
    }
}
