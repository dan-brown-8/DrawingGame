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

/// Takes an int and converts it into a nice String to be presented
class FormatTimeSpent {
    
    static func convertToString(timeSpent: Int) -> String {
        
        let minutes = Int(timeSpent / 60)
        let seconds = timeSpent % 60
        
        if (minutes == 0) {
            return "Time Spent:\n " + "\(seconds)" + " seconds"
        }
        else {
            return "Time Spent:\n " + "\(minutes)" + " minutes " + "\(seconds)" + " seconds"
        }
    }
}

class RandomString {
    static func generate(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}

