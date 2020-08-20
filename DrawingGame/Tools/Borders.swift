//
//  Borders.swift
//  DrawingGame
//
//  Created by Dan Brown on 8/19/20.
//  Copyright © 2020 Dan Brown. All rights reserved.
//

import UIKit

class Borders {
    
    static let THIN_BORDER_SIZE = CGFloat(0.3)
    static let NORMAL_BORDER_SIZE = CGFloat(1)
    static let BORDER_COLOR = UIColor.black.cgColor

    //Function that allows you to customize a button
    static func createBorders(buttonName: UIButton) {
        buttonName.layer.borderWidth = NORMAL_BORDER_SIZE
        buttonName.layer.borderColor = BORDER_COLOR
    }
    
    //Function that allows you to customize a View
    static func createBorders(viewName: UIView) {
        viewName.layer.borderWidth = NORMAL_BORDER_SIZE
        viewName.layer.borderColor = UIColor.black.cgColor
        viewName.layer.cornerRadius = 1
        
    }
    
    //Function that allows you to customize a text field
    static func createBorders(textFieldName: UITextField) {
        textFieldName.layer.borderWidth = NORMAL_BORDER_SIZE
        textFieldName.layer.borderColor = UIColor.black.cgColor
        
    }
    
    static func createThinBorders(buttonName: UIButton) {
        buttonName.layer.borderWidth = THIN_BORDER_SIZE
        buttonName.layer.borderColor = BORDER_COLOR
    }
    
    static func createThinBorders(labelName: UILabel) {
        labelName.layer.borderWidth = THIN_BORDER_SIZE
        labelName.layer.borderColor = BORDER_COLOR
    }
    
    //Function that allows you to customize a text field
    static func createThinBorders(textViewName: UITextView) {
        textViewName.layer.borderWidth = THIN_BORDER_SIZE
        textViewName.layer.borderColor = BORDER_COLOR
    }
    
    //Function that allows you to customize a text field
       static func createThinBorders(viewName: UIView) {
           viewName.layer.borderWidth = THIN_BORDER_SIZE
           viewName.layer.borderColor = BORDER_COLOR
           viewName.layer.cornerRadius = 1
       }
    
    //Function that allows you to customize a text field
    static func createThinBorders(textFieldName: UITextField) {
        textFieldName.layer.borderWidth = THIN_BORDER_SIZE
        textFieldName.layer.borderColor = BORDER_COLOR
    }
    
    //Function that allows you to customize a text field
    static func createThinBorders(imageName: UIImageView) {
        imageName.layer.borderWidth = THIN_BORDER_SIZE
        imageName.layer.borderColor = BORDER_COLOR
    }
    
    //Function that allows you to customize a tableView
    static func createBorders(tableName: UITableView) {
        tableName.layer.borderWidth = NORMAL_BORDER_SIZE
        tableName.layer.borderColor = BORDER_COLOR
        
        // TODO: Should probably move this to the format border class 'makeRound'
        tableName.layer.cornerRadius = 1
        
    }
    
    //Function that allows you to customize a label
    static func createBorders(labelName: UILabel) {
        labelName.layer.borderWidth = NORMAL_BORDER_SIZE
        labelName.layer.borderColor = BORDER_COLOR
        
        // TODO: Should probably move this to the format border class 'makeRound'
        labelName.layer.cornerRadius = 7
    }
}
