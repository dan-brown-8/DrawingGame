//
//  DrawingBoardVC.swift
//  DrawingGame
//
//  Created by Dan Brown on 8/19/20.
//  Copyright © 2020 Dan Brown. All rights reserved.
//

import UIKit
import Foundation

class DrawingBoardVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var drawingBoardView: DrawingBoardView!
    // Brush variables
    var lastPoint = CGPoint.zero
    var brushColor = UIColor.black
    var brushWidth : CGFloat = 4.5
    var opacity : CGFloat = 1.0
    var swiped = false
    
    var timer = Timer()
    var timeSpentDrawing : Int = 0
    var timerStarted : Bool = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
            
        self.title = "Drawing Board"
        createPickers()
    }
    
    /// Creates all of the pickers to be used in the VC
    func createPickers() {
        // The picker acts as input for the text field
        self.drawingBoardView.brushColorTextField.inputView = drawingBoardView.brushColorPicker
        self.drawingBoardView.utensilTextField.inputView = drawingBoardView.utensilPicker
        self.drawingBoardView.brushWidthTextField.inputView = drawingBoardView.brushWidthPicker

        // The toolbars for the picker views
        let doneToolBar = UIToolbar().DoneToolBar(mySelect: #selector(DrawingBoardVC.dismissPicker))

        self.drawingBoardView.brushColorTextField.inputAccessoryView = doneToolBar
        self.drawingBoardView.utensilTextField.inputAccessoryView = doneToolBar
        self.drawingBoardView.brushWidthTextField.inputAccessoryView = doneToolBar
        
        self.drawingBoardView.brushColorPicker.delegate = self
        self.drawingBoardView.brushColorPicker.dataSource = self
        
        self.drawingBoardView.utensilPicker.delegate = self
        self.drawingBoardView.utensilPicker.dataSource = self
        
        self.drawingBoardView.brushWidthPicker.delegate = self
        self.drawingBoardView.brushWidthPicker.dataSource = self
        
    }
    
    @objc func startTimer() {
        self.timeSpentDrawing += 1
    }
    
    /// Dismisses the picker and fills the text field
    @objc func dismissPicker() {
        // Fills the text field when 'Done' is pressed
        if (drawingBoardView.brushColorTextField.isEditing) {
            self.fillBrushColorTextField()
        }
        if (drawingBoardView.utensilTextField.isEditing) {
            self.fillUtensilTextField()
        }
        if (drawingBoardView.brushWidthTextField.isEditing) {
            self.fillBrushWidthTextField()
        }
        
        // Hide the picker
        view.endEditing(true)
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        if (timerStarted == false) {
            self.timerStarted = true
            // Start timer
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
        }

        swiped = false
        lastPoint = touch.location(in: drawingBoardView.mainImage)
    
    }
    
    /// Fills the text field once the picker is dismissed
    func fillBrushColorTextField() {
        let selectedRow : Int = drawingBoardView.brushColorPicker.selectedRow(inComponent: 0)
        drawingBoardView.brushColorTextField.text = drawingBoardView.brushColorOptions[selectedRow]
                                        
        // Get the brushes UIColor from the pickers String value
        let color = BrushSettings.colors[drawingBoardView.brushColorOptions[selectedRow]]
            
        if (drawingBoardView.utensilTextField.text == "Eraser") {
            self.brushColor = .white
        }
        else {
            self.brushColor = color ?? UIColor.black
        }
        
        // Make sure the text is still easily visible if the selected color is a light color
        if (color == UIColor.yellow || color == UIColor.green) {
            drawingBoardView.brushColorTextField.textColor = .black
        }
        else {
            drawingBoardView.brushColorTextField.textColor = .white
        }
        
        drawingBoardView.brushColorTextField.backgroundColor = color
    }
    
    func fillUtensilTextField() {
        let selectedRow : Int = drawingBoardView.utensilPicker.selectedRow(inComponent: 0)
        drawingBoardView.utensilTextField.text = drawingBoardView.utensilOptions[selectedRow]
        
        if (drawingBoardView.utensilOptions[selectedRow] == "Eraser") {
            self.brushColor = .white
        }
        else {
            let selectedRow : Int = drawingBoardView.brushColorPicker.selectedRow(inComponent: 0)
            self.brushColor = BrushSettings.colors[drawingBoardView.brushColorOptions[selectedRow]]!
        }
    }
    
    func fillBrushWidthTextField() {
        let selectedRow : Int = drawingBoardView.brushWidthPicker.selectedRow(inComponent: 0)
        drawingBoardView.brushWidthTextField.text = drawingBoardView.brushWidthOptions[selectedRow]
        
        // Adjust the brush width value
        let width = BrushSettings.width[drawingBoardView.brushWidthOptions[selectedRow]]
        self.brushWidth = width ?? 2.0
    }
    
    func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        // Draws a line between two points
        UIGraphicsBeginImageContext(drawingBoardView.mainImage.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
                return
        }
        drawingBoardView.tempDrawImage.image?.draw(in: drawingBoardView.tempDrawImage.bounds)
            
        // Draws a line between last point and current point, used to smooth out the strokes
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
            
        // Customize the style of the writing
        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.setLineWidth(brushWidth)
        context.setStrokeColor(brushColor.cgColor)
            
        // Used to actually draw the path
        context.strokePath()
        
        // Finish the drawing
        drawingBoardView.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext()
        drawingBoardView.tempDrawImage.alpha = opacity
        UIGraphicsEndImageContext()
    }
        
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        // Lets us keep track of when the user drags their finger along the screen
        swiped = true
        let currentPoint = touch.location(in: drawingBoardView.mainImage)
        drawLine(from: lastPoint, to: currentPoint)
        
        // Allows the user to continue where they left off
        lastPoint = currentPoint
    }
        
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            // draw a single point
            drawLine(from: lastPoint, to: lastPoint)
        }
            
        // Merge tempImageView into mainImageView
        UIGraphicsBeginImageContext(drawingBoardView.mainImage.frame.size)
        drawingBoardView.mainImage.image?.draw(in: drawingBoardView.mainImage.bounds, blendMode: .normal, alpha: 1.0)
        drawingBoardView.tempDrawImage?.image?.draw(in: drawingBoardView.tempDrawImage.bounds, blendMode: .normal, alpha: opacity) 
        drawingBoardView.mainImage.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
            
        drawingBoardView.tempDrawImage.image = nil
    }
        
    @IBAction func reset(_ sender: Any) {
        drawingBoardView.mainImage.image = nil
    }
        
    // Called when the 'Agree' button is pressed
    @IBAction func save(_ sender: Any) {
        let photo = drawingBoardView.mainImage.image!.jpegData(compressionQuality: 0.75)!
        
        // Generate a random 15 character id number
        let id = RandomString.generate(length: 15)
                        
        // Upload the drawing to Storage and create a document for the drawing in Firestore
        let uploadDrawing = UploadDrawing()
        uploadDrawing.uploadPhoto(photoId: "\(id)", data: photo)
        uploadDrawing.createDrawingDocument(id: "\(id)", timeSpent: self.timeSpentDrawing)
        
        // Stop timer
        timer.invalidate()
        
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: UIPickerViewDelegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // The # of rows = the amount of options in the picker
        if (drawingBoardView.brushColorPicker == pickerView) {
            return drawingBoardView.brushColorOptions.count }
        else if (drawingBoardView.brushWidthPicker == pickerView) {
            return drawingBoardView.brushWidthOptions.count }
        else {
            return drawingBoardView.utensilOptions.count }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        // Set the title as the text in the corresponding row
        switch pickerView {
        case drawingBoardView.brushColorPicker:
            return drawingBoardView.brushColorOptions[row]
        case drawingBoardView.utensilPicker:
            return drawingBoardView.utensilOptions[row]
        case drawingBoardView.brushWidthPicker:
            return drawingBoardView.brushWidthOptions[row]
        default:
            return "Error"
        }
    }
}
