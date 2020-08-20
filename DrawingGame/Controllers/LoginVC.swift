//
//  LoginVC.swift
//  DrawingGame
//
//  Created by Dan Brown on 8/19/20.
//  Copyright © 2020 Dan Brown. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class LoginVC: UIViewController, BeginLoginDelegate {
    
    @IBOutlet var loginView: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Make the navigation bar invisible
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
              
        // Sets the color of the 'Back' button on the navigation bar
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        loginView.stopAnimatingSpinner()
    }
    
 /**
     What occurs when the submit button is pressed
     
     - NOTE: Firebase has many of their own ways to tell the user if their info is incorrect
     */
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        loginView.startAnimatingSpinner()

        // Assign user inputted email and password
        if let email = (self.loginView.emailTextField.text)?.lowercased(), let password = self.loginView.passwordTextField.text {
            
            User.setEmail(email: email)
                                
            // Call Firebase Authentication, attempt to sign in with email and password
            Auth.auth().signIn(withEmail: User.getEmail(), password: password) { (user, error) in
                if user != nil {
                    
                    // If the email/password were found, enter the app
                    let getUserData : GetUserData = GetUserData()
                    
                    print("Successful login")
                    getUserData.delegate = self
                    
                    getUserData.pullFromDatabase(email: User.getEmail())
                }
                else {
                    self.loginView.stopAnimatingSpinner()
                    
                    print(error)
                    
                    // If the email/password weren't found, display a popup message
                    let alert = UIAlertController(title: "Incorrect email or password", message: "Please try again", preferredStyle: .alert )
                    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    // If register button is tapped, move to the registration view
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        
        print("Register button tapped")
        self.performSegue(withIdentifier: "toSignUp", sender: self)
        
    }
    
    // Dismisses the keyboard when the view is tapped on
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.loginView.emailTextField.resignFirstResponder()
        self.loginView.passwordTextField.resignFirstResponder()
    }
      
    /// Called once the user data is retrieved from the database, part of the beginLoginDelegate
    func segueToPublicList() {
        // If the email/password were found, enter the app
        self.performSegue(withIdentifier: "loginSuccessful", sender: self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}




