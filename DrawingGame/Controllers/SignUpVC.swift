//
//  SignUpVC.swift
//  DrawingGame
//
//  Created by Dan Brown on 8/19/20.
//  Copyright © 2020 Dan Brown. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpVC: UIViewController, AccountCreatedDelegate {
    
    /// A variable to hold the user inputted email. Will be used to pass the email String to the next ViewController as 'userID'
    var email: String?
    
    /// A variable to hold the user inputted password. Used to check if the password is valid.
    var password: String?
    
    @IBOutlet var signUpView: SignUpView!
        
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        signUpView.stopAnimatingSpinner()
    }
    
    // MARK: UI Interactions
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        
        signUpView.startAnimatingSpinner()
        
        email = signUpView.emailTextField.text! // Assigns the user inputted email to the email variable
        password = signUpView.passwordTextField.text! // Assigns the user inputted password to the password variable
        
        // Check to see if there the email is valid
        Auth.auth().fetchSignInMethods(forEmail: email!.lowercased(), completion: {
            (methods, error) in
            
            if let error = error {
                print(error.localizedDescription)
                
                self.signUpView.stopAnimatingSpinner()
                
                let title = "Please enter a valid email address"
                let message = ""
                CommonAlerts.showAlert(vc: self, title: title, message: message)
            } else if let methods = methods { // If the email already has an account associated with it
                print(methods)
                self.signUpView.stopAnimatingSpinner()

                let title = "There is already an account associated with this email address"
                let message = "Sign-in or register with a different email"
                CommonAlerts.showAlert(vc: self, title: title, message: message)
            }
            else {
                if (self.isPasswordValid()) {
                    // If the password is valid, create the user account
                    self.createUser(email: self.email!.lowercased(), password: self.password!)
                }
            }
        })
    }
    
    /**
     Checks if the user inputted password is valid
     
     - TODO: Add additional situations/warnings where the password is invalid
     */
    func isPasswordValid() -> Bool {
        // If password and confirm password match and the password is 6 or more characters long
        if let password = signUpView.passwordTextField.text, let confirmPassword = signUpView.confirmPasswordTextField.text {
            if (password == confirmPassword && password.count >= 6) {
                return true
            }
            else if (password != confirmPassword) {
                // If the password and confirm password don't match
                let title = "Confirm Password must match Password"
                let message = "Please try again"
                CommonAlerts.showAlert(vc: self, title: title, message: message)
                return false
                
            }
            else {
                // If the password is less than 6 characters long
                let title = "Password must be at least 6 characters long"
                let message = "Please try again"
                CommonAlerts.showAlert(vc: self, title: title, message: message)
                return false
            }
        }
        return false
    }
    
    // MARK: Seguing and preparing to segue

    /// Called once the user data is retrieved from the database, part of the beginLoginDelegate
    func segueToPublicList() {
        // Append the job data into the 2D array
        self.performSegue(withIdentifier: "signUpSuccessful", sender: self)
    }
    
    // MARK: Creating accounts, completing the registration
    
    /// Creates the user in Firebase Authorization
    func createUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            
            if let user = authResult?.user {
                
                let register = RegisterUser()
              //  print("Ready to register the user")
                
                register.delegate = self
                // Store all of the registration data to the Database
                register.createDocument(email: self.signUpView.emailTextField.text!.lowercased(), displayName: self.signUpView.displayNameTextField.text!)
                
            }
            else {
                self.signUpView.stopAnimatingSpinner()
                // If the Firebase Authentication account cannot be created, display a popup message
                // TODO: Add (or the email address is invalid)
                let title = "An account already exists with that email address"
                let message = "Try a different email"
                CommonAlerts.showAlert(vc: self, title: title, message: message)
                
            }
        }
    }
    
    // Dismisses the keyboard when the view is tapped on
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.signUpView.emailTextField.resignFirstResponder()
        self.signUpView.passwordTextField.resignFirstResponder()
    }
}



