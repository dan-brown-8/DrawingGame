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

/**
 Used to send the photo that was downloaded to the ViewController
 
 - *getPhoto*: Returns the photo that was downloaded from Firebase
 
 */
protocol GetPhotoDelegate: class {
    func getPhoto(data: Data, id: String)
    func clearPhotoDictionary()
}

protocol GetDrawingDataDelegate : class {
    func updateData(data: [DrawingDataModel])
    func clearDrawingDataArray()
    func reloadTable()
}

/// Handle retrieving all drawing data and images
class DownloadDrawings {
        
    // MARK: Listener for updates to the drawings in the database
    static var drawingListener : ListenerRegistration?
        
    /// Singleton so the class can only be called once
    static let singleton = DownloadDrawings()
    
    weak var dataDelegate : GetDrawingDataDelegate?
    weak var photoDelegate : GetPhotoDelegate?
    
    // Initialize database
    var db = Firestore.firestore()
    
    init() {
        // Disable deprecated features
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
    
    /// Counts the number of times that the database has been queried
    var countQueries = 0
        
    func listen() {
            
        /// Collection that holds the needed documents
        let collection = db.collection("drawings")
            
        // Pull the document data from the database
        DownloadDrawings.drawingListener = collection.addSnapshotListener
            { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                }
                else {
                    guard let snapshot = querySnapshot else {
                        print("Error fetching snapshots: \(err!)")
                        return
                    }
                    // What occurs when a document is added, modified, or removed from the subset
                    snapshot.documentChanges.forEach { diff in
                            
                        if (diff.type == .added) {
                            // If this is the first time the documents are added, add them all into the photo dictionary
                            if (self.countQueries == 0) {
                                //print("Data added")
                                // Clear photo array before reloading them
                                self.photoDelegate?.clearPhotoDictionary()
                                    
                                // A short delay to allow the new photo to populate in Firebase Storage
                                let secondsToDelay = 1.0
                                DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) {
                                    self.getListenerData(querySnapshot: querySnapshot!)
                                }
                                    
                                // Don't allow any duplicate database queries
                                self.countQueries += 1
                            }
                            else {
                                return
                            }
                        }
                        if (diff.type == .modified) { // If the document data has been modified
                            print("Data modified")
                            self.getListenerData(querySnapshot: querySnapshot!)
                                
                        }
                        if (diff.type == .removed) { // If the document data has been removed
                            print("Data removed")
                            self.getListenerData(querySnapshot: querySnapshot!)
                        }
                    }
                    // Reset the count to 0, so more documents can be added if necessary
                    self.countQueries = 0
                }
        }
    }
        
    func getListenerData(querySnapshot: QuerySnapshot) {
            
        let drawingData = getDrawingData(documents: querySnapshot.documents)
            
        // Passes the job data array to a ViewController
        self.dataDelegate?.updateData(data: drawingData)
        // Reload the table to display the new data
        self.dataDelegate?.reloadTable()
    }
        
    /// Creates an array of DrawingDataModel using the Firebase query
    func getDrawingData(documents: [QueryDocumentSnapshot]) -> [DrawingDataModel] {
        var drawings : [DrawingDataModel] = []
        for document in documents {
            drawings.append(DrawingDataModel(document: document))
            // Downlaod the photo that corresponds with the drawing document
            self.downloadPhoto(id: document.documentID)
        }
            
        return drawings
    }
    

    /// Download the image to be displayed on a View Controller
    func downloadPhoto(id: String) {
        // Get a reference to the storage service using the default Firebase App
        let storage = Storage.storage()
        
        print("Downloading drawing photo")
        
        // Create a storage reference to match the path of the needed image
        let storageRef = storage.reference(withPath: "photos/" + id)
        
        // Download in memory with a maximum allowed size of 4MB (4 * 1024 * 1024 bytes)
        storageRef.getData(maxSize: 4 * 1024 * 1024) { data, error in
            if let error = error {
                print("ERROR Downloading the drawing photo: " + "\(error)")
                // Uh-oh, an error occurred!
            } else {
                // Data for the image is returned
                print("Download Occuring")
                self.photoDelegate?.getPhoto(data: data!, id: id)
                
            }
        }
    }
    
}

