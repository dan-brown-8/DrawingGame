//
//  DrawingDetailsView.swift
//  DrawingGame
//
//  Created by Dan Brown on 8/21/20.
//  Copyright © 2020 Dan Brown. All rights reserved.
//

import Foundation
import UIKit

class DrawingDetailsView: UIView {
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var drawingImage: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var timeSpentLabel: UILabel!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var dateAndTimeCreatedLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Create a border around the view
        Borders.createBorders(viewName: self)
        // Rounds out the edges of the view
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
                                
        formatViews()
    }
    
    func formatViews() {
        // Rounds out the exit button and fades the color a bit
        FormatButton.makeRound(button: deleteButton, cornerRadius: 5)
        Borders.createThinBorders(buttonName: deleteButton)
        
        // Rounds out the exit button and fades the color a bit
        FormatButton.makeRound(button: exitButton, cornerRadius: 5)
        Borders.createThinBorders(buttonName: exitButton)
        
        Borders.createBorders(imageName: drawingImage)
        
    }
    
}
