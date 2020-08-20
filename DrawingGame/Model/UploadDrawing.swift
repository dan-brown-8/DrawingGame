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

/// Download/Upload data to Firebase Storage
class UploadDrawing {
    
    // Initialize database
    var db = Firestore.firestore()
    
    /// Used to login the user once the account has been created
    weak var delegate : AccountCreatedDelegate?
    
    init() {
        // Disable deprecated features
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
    
    /// Upload the parents ID so we can confirm that their information is correct
    func uploadPhoto(photoId: String, data: Data) {
        // Get a reference to the storage service using the default Firebase App
        let storage = Storage.storage()
        
        // CHANGE THE VERSION # IF WE CHANGE THE TEENPARENT AGREEMENT
        // Create a storage reference from our storage service
        let storageRef = storage.reference(withPath: "photos/" + photoId)
        
        // Upload the file to the path "job/(jobType)/(jobID)/(jobPhase)"
        let uploadTask = storageRef.putData(data, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                print("METADATA ERROR")
                return
            }
            // Metadata contains file metadata such as size, content-type.
            let size = metadata.size
            // You can also access to download URL after upload.
            storageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
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
            "artist": User.getEmail(),
            "displayName": User.getDisplayName(),
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
