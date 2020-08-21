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

/// Tracks the iphone screen size
extension UIDevice {
    var iPhoneX: Bool {
        return UIScreen.main.nativeBounds.height == 2436
    }
    var iPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    enum ScreenType: String {
        case iPhones_4_4S = "iPhone 4 or iPhone 4S"
        case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhones_X_XS = "iPhone X or iPhone XS"
        case iPhone_XR = "iPhone XR"
        case iPhone_XSMax = "iPhone XS Max"
        case unknown
    }
    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhones_4_4S
        case 1136:
            return .iPhones_5_5s_5c_SE
        case 1334:
            return .iPhones_6_6s_7_8
        case 1792:
            return .iPhone_XR
        case 1920, 2208:
            return .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2436:
            return .iPhones_X_XS
        case 2688:
            return .iPhone_XSMax
        default:
            return .unknown
        }
    }
}
