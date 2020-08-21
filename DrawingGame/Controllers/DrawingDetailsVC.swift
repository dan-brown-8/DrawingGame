//
//  DrawingDetailsVC.swift
//  DrawingGame
//
//  Created by Dan Brown on 8/21/20.
//  Copyright © 2020 Dan Brown. All rights reserved.
//

import UIKit

class DrawingDetailsVC: UIViewController {

    @IBOutlet weak var drawingDetailsView: DrawingDetailsView!
    
    var drawingData : DrawingDataModel = DrawingDataModel()
    
    var drawingImage : UIImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets the title of the navigation bar
        self.navigationItem.title = "Drawing Details"
    
        setupViews()
        
    }
    
    @IBAction func exitButtonPressed(_ sender: Any) {
        removeAnimation()
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        deleteDrawing()
    }
    
    /// Set up the Views so they will be displayed correctly when the VC loads
    func setupViews() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.view.bringSubviewToFront(drawingDetailsView)
        
        // Dont allow users to delete drawings that aren't theirs
        if (drawingData.getArtist() != UserDataModel.getEmail()) {
            drawingDetailsView.deleteButton.isHidden = true
        }
        
        let date = FormatDate.formatDate(timestamp: drawingData.getDateCreated())
            
        drawingDetailsView.artistLabel.text = "By " + drawingData.getDisplayName()
        drawingDetailsView.timeSpentLabel.text = formatTimeSpent()
        drawingDetailsView.dateAndTimeCreatedLabel.text = date
        drawingDetailsView.drawingImage.image = self.drawingImage
        
        self.showAnimation()
    }
    
    /// Return time spent as a String that will be cleanly displayed on the view
    func formatTimeSpent() -> String {
        let minutes = Int(drawingData.getTimeSpent() / 60)
        let seconds = drawingData.getTimeSpent() % 60
        
        if (minutes == 0) {
            return "Time Spent:\n " + "\(seconds)" + " seconds"
        }
        else {
            return "Time Spent:\n " + "\(minutes)" + " minutes " + "\(seconds)" + " seconds"
        }
    }
    
    func loadInDrawingVideo() {
        print("Loads in the drawing videos and plays it")
    }
    
    func deleteDrawing() {
        // Ask the user to confirm they'd like to delete the drawing
        let alert = UIAlertController(title: "Are you sure you want to delete your drawing?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            
            let deleteInFirebase = DeleteDrawing()
            
            deleteInFirebase.deleteDrawingDocument(id: self.drawingData.getDocId())
            deleteInFirebase.deletePhoto(photoId: self.drawingData.getDocId())
            
            _ = self.navigationController?.popViewController(animated: true)
            self.removeAnimation()
            
            // notify teenPros that had applied to job
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /// Animates the viewController as it pops up
    func showAnimation() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    /// Animates the viewController as it exits
    func removeAnimation() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished) {
                self.view.removeFromSuperview()
                self.navigationController?.popToRootViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
            }
        });
    }
}
