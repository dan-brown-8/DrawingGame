//
//  DrawingBoardView.swift
//  DrawingGame
//
//  Created by Dan Brown on 8/19/20.
//  Copyright © 2020 Dan Brown. All rights reserved.
//

import UIKit

class DrawingBoardView: UIView, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var tempDrawImage: UIImageView!
    
    @IBOutlet weak var brushColorTextField: UITextField!
    @IBOutlet weak var utensilTextField: UITextField!
    @IBOutlet weak var brushWidthTextField: UITextField!
    
    // Create the pickers
    let brushColorPicker = UIPickerView()
    let utensilPicker = UIPickerView()
    let brushWidthPicker = UIPickerView()
    
    let brushColorOptions = ["Black", "Green", "Blue", "Red", "Yellow"]
    let utensilOptions = ["Brush", "Eraser"]
    let brushWidthOptions = ["Extra Thin", "Thin", "Medium", "Thick", "Extra Thick"]

    /* var lastPoint = CGPoint.zero
    var color = UIColor.black
    var brushWidth : CGFloat = 2.0
    var opacity : CGFloat = 1.0
    var swiped = false */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("View Display")
        
        // Creates the borders for the specified objects
        createBorders()
        
        brushColorTextField.delegate = self
        utensilTextField.delegate = self
        brushWidthTextField.delegate = self
        
        // Change the placeholder text color to black
        brushColorTextField.attributedPlaceholder = NSAttributedString(string: "Black",
                                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        // Change the placeholder text color to black
        utensilTextField.attributedPlaceholder = NSAttributedString(string: "Brush",
                                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        // Change the placeholder text color to black
        brushWidthTextField.attributedPlaceholder = NSAttributedString(string: "Medium",
                                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        //self.backgroundColor = UIColor.lightGray()
        self.bringSubviewToFront(mainImage)
        self.bringSubviewToFront(tempDrawImage)
    }
    
    /// Adds borders to the views
    private func createBorders() {
        Borders.createThinBorders(imageName: mainImage)
        Borders.createThinBorders(textFieldName: brushColorTextField)
        Borders.createThinBorders(textFieldName: utensilTextField)
        Borders.createThinBorders(textFieldName: brushWidthTextField)
    }
    
}
