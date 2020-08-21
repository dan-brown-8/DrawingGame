//
//  RegisterUser.swift
//  DrawingGame
//
//  Created by Dan Brown on 8/20/20.
//  Copyright © 2020 Dan Brown. All rights reserved.
//

import FirebaseFirestore

// Creates the account using the data inputted in the RegisterVC
protocol AccountCreatedDelegate : class {
    func segueToPublicList()
}

/// This class contains functions that create new documents in the database.
class RegisterUser {
    
    // Initialize database
    var db = Firestore.firestore()
    
    /// Used to login the user once the account has been created
    weak var delegate : AccountCreatedDelegate?
    
    init() {
        // Disable deprecated features
        let settings = db.settings
     //   settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
    
    /// Create the user document in Firebase
    func createDocument(email: String?, displayName: String?) {
        
        print("Registering User")
        
        let newUser: [String: Any] = [
            "emailAddress": email!.lowercased(),
            "displayName": displayName!,
        ]
        
        // Create user
        db.collection("users").document(email!.lowercased()).setData(newUser) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                UserDataModel.setDisplayName(displayName: displayName!)
                self.delegate?.segueToPublicList()
            }
        }
    }

}
