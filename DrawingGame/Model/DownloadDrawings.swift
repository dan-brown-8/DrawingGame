//
//  DownloadDrawing.swift
//  DrawingGame
//
//  Created by Dan Brown on 8/20/20.
//  Copyright © 2020 Dan Brown. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

/// Download/Upload data to Firebase Storage
class DownloadDrawings {
    
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

    
    
}

