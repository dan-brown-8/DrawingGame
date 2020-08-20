//
//  SignUpView.swift
//  DrawingGame
//
//  Created by Dan Brown on 8/19/20.
//  Copyright © 2020 Dan Brown. All rights reserved.
//

import UIKit

class SignUpView: UIView, UITextFieldDelegate {
    
    // MARK: Outlets for Text Fields
    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!

    @IBOutlet weak var loadingSpinnerView: UIActivityIndicatorView!
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addBorders()
        loadingSpinnerView.stopAnimating()
        FormatButton.makeRound(button: submitButton, cornerRadius: 5)
        
        // Allows the return button to close the keyboard
        assignTextFieldDelegates()
        
    }
    
    /// Have the text fields conform to the text field delegate
    func assignTextFieldDelegates() {
        displayNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }
        
    /// Starts the animation of the spinner
    func startAnimatingSpinner() {
        loadingSpinnerView.startAnimating()
        submitButton.isEnabled = false
    }
    
    /// Stops the animation of the spinner
    func stopAnimatingSpinner() {
        loadingSpinnerView.stopAnimating()
        submitButton.isEnabled = true
    }
    
    /// Adds borders where necessary
    func addBorders() {
        Borders.createThinBorders(textFieldName: displayNameTextField)
        Borders.createThinBorders(textFieldName: emailTextField)
        Borders.createThinBorders(textFieldName: passwordTextField)
        Borders.createThinBorders(textFieldName: confirmPasswordTextField)
        Borders.createThinBorders(buttonName: submitButton)
    }
    
    /// Closes keyboard when 'Return' is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
}
