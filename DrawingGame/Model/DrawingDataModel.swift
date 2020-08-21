//
//  DrawingDataModel.swift
//  DrawingGame
//
//  Created by Dan Brown on 8/20/20.
//  Copyright © 2020 Dan Brown. All rights reserved.
//

import Foundation
import FirebaseFirestore

class DrawingDataModel {
    
    private var artist : String = ""
    private var displayName : String = ""
    private var timeSpent : Int = 0
    private var dateCreated : Double = 0.0
    private var videoReference : String = ""
    private var docId : String = ""
        
    init() {
    }
    
    // Called when loading in drawing data from Firebase
    init(document: DocumentSnapshot) {
        if let artist = document.get("artist") as? String { setArtist(artist: artist) }
        if let dateCreated = document.get("dateCreated") as? Double { setDateCreated(dateCreated: dateCreated) }
        if let displayName = document.get("displayName") as? String { setDisplayName(displayName: displayName) }
        if let timeSpent = document.get("timeSpent") as? Int { setTimeSpent(timeSpent: timeSpent) }
        if let videoReference = document.get("videoReference") as? String { setVideoReference(videoReference: videoReference) }
        setDocId(docId: document.documentID)
    }

    
    // MARK: Accessors

    public func getArtist() -> String {
        return artist
    }
    
    public func getDisplayName() -> String {
        return displayName
    }
    
    public func getTimeSpent() -> Int {
        return timeSpent
    }
    
    public func getDateCreated() -> Double {
        return dateCreated
    }
    
    public func getVideoReference() -> String {
        return videoReference
    }
    
    public func getDocId() -> String {
        return docId
    }
    
    // MARK: Mutators

    public func setArtist(artist : String) {
        self.artist = artist.lowercased()
    }
    
    public func setDisplayName(displayName : String) {
        self.displayName = displayName
    }

    public func setTimeSpent(timeSpent : Int) {
        self.timeSpent = timeSpent
    }
    
    public func setDateCreated(dateCreated : Double) {
        self.dateCreated = dateCreated
    }
    
    public func setVideoReference(videoReference : String) {
        self.videoReference = videoReference
    }
    
    public func setDocId(docId : String) {
        self.docId = docId
    }
}
