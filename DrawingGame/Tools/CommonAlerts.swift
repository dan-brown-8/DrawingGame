//
//  CommonAlerts.swift
//  DrawingGame
//
//  Created by Dan Brown on 8/20/20.
//  Copyright © 2020 Dan Brown. All rights reserved.
//

import Foundation
import UIKit


/// This class contains common button operations.
class CommonAlerts {
    
    /**
     This function creates an alert on the user's screen.
     
     - Parameters:
     - vc: The View Controller that the user is currently viewing. The alert will be displayed on top of this View Controller.
     - title: The title of the alert. Use this string to get the user’s attention and communicate the reason for the alert.
     - message: Descriptive text that provides additional details about the reason for the alert.
     
     */
    class func showAlert(vc: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default Actions"), style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
