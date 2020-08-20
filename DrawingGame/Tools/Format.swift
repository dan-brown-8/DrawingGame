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
