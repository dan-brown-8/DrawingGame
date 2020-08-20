//
//  Extensions.swift
//  DrawingGame
//
//  Created by Dan Brown on 8/19/20.
//  Copyright © 2020 Dan Brown. All rights reserved.
//

import UIKit

// Toolbar used to display a 'done' option on the picker
extension UIToolbar {
   
    /// Toolbar that contains only the 'Done' button
    func DoneToolBar(mySelect : Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        
        // Format the toolbar
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        if #available(iOS 13.0, *) {
            toolBar.tintColor = UIColor.label
        } else {
            // Fallback on earlier versions
            toolBar.tintColor = UIColor.black
        }
        toolBar.sizeToFit()
        
        // Create the done button and space button
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: mySelect)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
}

// Allows us to add an image to the background of the View
extension UIColor {
    /**
     Converts this `UIColor` instance to a 1x1 `UIImage` instance and returns it. Utilized for the border underneath the navigation bars.
     - Returns: `self` as a 1x1 `UIImage`. **/
    func asOneByOneImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}
