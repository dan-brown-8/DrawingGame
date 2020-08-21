//
//  DeleteDrawing.swift
//  DrawingGame
//
//  Created by Dan Brown on 8/21/20.
//  Copyright © 2020 Dan Brown. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

/// Delete drawing from Storage and Firestore
class DeleteDrawing {
    
    // Initialize database
    var db = Firestore.firestore()
    
    init() {
        // Disable deprecated features
        let settings = db.settings
     //   settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
    
    /// Delete the photo of the drawing in Firebase Storage
    func deletePhoto(photoId: String) {
        
        let storage = Storage.storage()
        let storageRef = storage.reference(withPath: "photos/" + photoId)

        // Delete the file
        storageRef.delete { error in
          if let error = error {
            // Uh-oh, an error occurred!
            print("Error deleting photo: \(error)")
          } else {
            print("Photo successfully deleted!")
          }
        }
    }
    
    /// Delete the drawing document in Firebase
    func deleteDrawingDocument(id: String) {
        db.collection("drawings").document(id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}
