//
//  LoginView.swift
//  DrawingGame
//
//  Created by Dan Brown on 8/19/20.
//  Copyright © 2020 Dan Brown. All rights reserved.
//

import UIKit

class LoginView: UIView, UITextFieldDelegate {

// MARK: Outlets for Text Fields
@IBOutlet weak var emailTextField: UITextField!
@IBOutlet weak var passwordTextField: UITextField!

@IBOutlet weak var submitButton: UIButton!
@IBOutlet weak var registerButton: UIButton!

@IBOutlet weak var loadingSpinnerView: UIActivityIndicatorView!

override func awakeFromNib() {
    super.awakeFromNib()
    
    addBorders()
    
    loadingSpinnerView.stopAnimating()
    
    FormatButton.makeRound(button: submitButton, cornerRadius: 5)
    FormatButton.makeRound(button: registerButton, cornerRadius: 5)
    
    emailTextField.adjustsFontSizeToFitWidth = true
    
    // Allows the return button to close the keyboard
    assignTextFieldDelegates()
        
}
    
    /// Have the text fields conform to the text field delegate
    func assignTextFieldDelegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    /// Starts the animation of the spinner
    func startAnimatingSpinner() {
        loadingSpinnerView.startAnimating()
        submitButton.isEnabled = false
        registerButton.isEnabled = false
    }

    /// Stops the animation of the spinner
    func stopAnimatingSpinner() {
        loadingSpinnerView.stopAnimating()
        submitButton.isEnabled = true
        registerButton.isEnabled = true
    }

    /// Adds borders where necessary
    func addBorders() {
        Borders.createThinBorders(textFieldName: emailTextField)
        Borders.createThinBorders(textFieldName: passwordTextField)
    
        Borders.createThinBorders(buttonName: submitButton)
        Borders.createThinBorders(buttonName: registerButton)
    
    }

    /// Closes keyboard when 'Return' is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
}
