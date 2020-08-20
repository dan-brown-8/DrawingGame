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
    /// Toolbar that contains a 'clear' button and 'done' button. Typically used for optional fields.
    func ClearAndDoneToolBar(mySelect : Selector, clearSelect : Selector) -> UIToolbar {
        
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
        let clearButton = UIBarButtonItem(title: "Clear", style: UIBarButtonItem.Style.plain, target: self, action: clearSelect)
        
        toolBar.setItems([ clearButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
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
