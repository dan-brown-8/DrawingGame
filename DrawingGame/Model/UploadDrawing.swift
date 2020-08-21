//
//  FirebaseStorage.swift
//  DrawingGame
//
//  Created by Dan Brown on 8/20/20.
//  Copyright © 2020 Dan Brown. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

/// Upload photo to Firebase Storage and the drawing data to Firestore
class UploadDrawing {
    
    // Initialize database
    var db = Firestore.firestore()
    
    init() {
        // Disable deprecated features
        let settings = db.settings
       // settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
    
    /// Upload the parents ID so we can confirm that their information is correct
    func uploadPhoto(photoId: String, data: Data) {
        // Get a reference to the storage service using the default Firebase App
        let storage = Storage.storage()
        
        // Create a storage reference from our storage service
        let storageRef = storage.reference(withPath: "photos/" + photoId)
        
        _ = storageRef.putData(data, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                print("METADATA ERROR")
                return
            }
            // You can also access to download URL after upload.
            storageRef.downloadURL { (url, error) in
                guard url != nil else {
                    print("URL ERROR")
                    return
                }
            }
        }
    }
    
    /// Create the user document in Firebase
    func createDrawingDocument(id: String, timeSpent: Int) {
        
        print("Creating photo document")
        
        let newDrawing: [String: Any] = [
            "artist": UserDataModel.getEmail(),
            "displayName": UserDataModel.getDisplayName(),
            "videoReference": "null",
            "timeSpent": timeSpent,
            "dateCreated": NSDate().timeIntervalSince1970
        ]
        
        // Create drawing doc
        db.collection("drawings").document(id).setData(newDrawing) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
}
