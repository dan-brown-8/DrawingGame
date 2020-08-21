//
//  Format.swift
//  DrawingGame
//
//  Created by Dan Brown on 8/20/20.
//  Copyright © 2020 Dan Brown. All rights reserved.
//

import UIKit

// Call this class to format a button for you
class FormatButton: UIButton {
    
    /// Takes a button as a parameter, makes it round, then returns the rounded button
    static func makeRound(button: UIButton, cornerRadius: CGFloat) {
        button.layer.cornerRadius = cornerRadius
        button.clipsToBounds = true
    }
}

/// This class takes a timestamp, assigns the date and time to separate variables, and formats the variables to be displayed in a ViewController
class FormatDate {
    
    /// Formats the timestamp into a date that will be displayed on a ViewController.
    static func formatDate(timestamp: Double) -> String {
        
        let myTimeInterval = TimeInterval(timestamp)
        let date = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
        
        let dateFormatter = DateFormatter()
    
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "en_US")
        
        return dateFormatter.string(from: date as Date)
    }
}

