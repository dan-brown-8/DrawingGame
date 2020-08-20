//
//  User.swift
//  DrawingGame
//
//  Created by Dan Brown on 8/20/20.
//  Copyright © 2020 Dan Brown. All rights reserved.
//

import Foundation

class User {
    
    private static var email : String = ""
    private static var displayName : String = ""
    
    let shared = User()
    
    private init() {}
    
    // MARK: Accessors

    public static func getEmail() -> String {
        return email
    }
    
    public static func getDisplayName() -> String {
        return displayName
    }
    
    // MARK: Mutators

    public static func setEmail(email : String) {
        self.email = email.lowercased()
    }
    
    public static func setDisplayName(displayName : String) {
        self.displayName = displayName
    }

}
