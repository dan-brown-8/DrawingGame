//
//  GetUserData.swift
//  DrawingGame
//
//  Created by Dan Brown on 8/20/20.
//  Copyright © 2020 Dan Brown. All rights reserved.
//

import FirebaseCore
import FirebaseFirestore

protocol BeginLoginDelegate : class {
    func segueToPublicList()
}
/// Retrieves the users data from the database
class GetUserData {
    
    // Initialize database
    var db = Firestore.firestore()
    
    // Assign a variable to the delegate so you can utilize it later in the program
    weak var delegate : BeginLoginDelegate?
    
    init() {
        // Disable deprecated features
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
    
    /// Pull the user data from the database
    func pullFromDatabase(email : String) {
        
        print("Pull from db")
        
        /// The collection we are referencing in Firebase
        let docRef = db.collection("users").document(email.lowercased())
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                
                // Grab any additional user data here
                User.setDisplayName(displayName: "displayName")
                
                self.delegate?.segueToPublicList()
            }
            else {
                print("Error, no doc exists")
                print(error)
            }

        }
    }
}
