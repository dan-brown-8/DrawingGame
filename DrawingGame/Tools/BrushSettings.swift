//
//  Colors.swift
//  DrawingGame
//
//  Created by Dan Brown on 8/19/20.
//  Copyright © 2020 Dan Brown. All rights reserved.
//

import UIKit

/// Allows us to simply convert a String to a color
class BrushSettings {
    
    /// A dictionary of colors
    static let colors : [String:UIColor] =
        ["Black": UIColor.black,
         "Green": UIColor.green,
         "Blue": UIColor.blue,
         "Red": UIColor.red,
         "Yellow": UIColor.yellow]
    
    static let width : [String:CGFloat] =
        ["Extra Thin": 0.5,
         "Thin": 3.0,
         "Medium": 4.5,
        "Thick": 6.0,
        "Extra Thick": 7.5]
}
