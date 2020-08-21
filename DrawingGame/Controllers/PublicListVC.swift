//
//  PublicListVC.swift
//  DrawingGame
//
//  Created by Dan Brown on 8/19/20.
//  Copyright © 2020 Dan Brown. All rights reserved.
//

import UIKit

class PublicListVC: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    @IBOutlet var publicListView: PublicListView!
    
    /// The thumbnail images of the drawings.
    var drawingImages : NSMutableDictionary = NSMutableDictionary()
    
    /// The data that corresponds with the drawings
    var drawingData : [DrawingDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create proper spacing for the collectionView
        let width = (view.frame.size.width - 20) / 3
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
        configureNavigationBar()
        populateDrawingPhotos()
        
    }
    
    /// Activate the Firebase listener and grab the drawing photos
    func populateDrawingPhotos() {
        DownloadDrawings.singleton.dataDelegate = self
        DownloadDrawings.singleton.photoDelegate = self
        DownloadDrawings.singleton.listen()
    }
    
    func configureNavigationBar() {
        // Add pencil image as navigation bar button
        let imageBarButton = UIBarButtonItem(image: UIImage(named: "Pencil3.png")!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.action(sender:)))
        
        // Adds the New+ button to the navigation bar
        self.navigationItem.rightBarButtonItem = imageBarButton
        
        // Sets the title and back bar color of the navigation bar
        self.navigationItem.title = "Public Drawings"
    }
    
    // Handle what happens when the pencil icon is pressed
    @objc func action(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toNewDrawing", sender: self)
    }
}
    
extension PublicListVC: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
        
    func collectionView(_ collectionView: UICollectionView,
                                    numberOfItemsInSection section: Int) -> Int {
        return drawingImages.count
    }
        
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! DrawingCollectionViewCell
            
        // Make sure the drawing data and drawing images are linked/parallel
        let imageRef = self.drawingData[indexPath.row].getDocId()
        cell.drawingImage.image = self.drawingImages[imageRef] as? UIImage
        
        return cell
    }
    // When a drawing is selected, display the drawing details pop up and pass in the data
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "drawingDetailsId") as! DrawingDetailsVC
        popUpVC.drawingData = self.drawingData[indexPath.row]
        
        let imageRef = self.drawingData[indexPath.row].getDocId()
        popUpVC.drawingImage = (self.drawingImages[imageRef] as? UIImage)!
        PresentPopUpVC.presentPopUp(popUpVC: popUpVC, presentingVC: self)
    }


}

extension PublicListVC: GetPhotoDelegate {
    /// Protocol that receives the downloaded photo
    func getPhoto(data: Data, id: String) {
        self.drawingImages.setValue(UIImage(data: data)!, forKey: id)
        collectionView.reloadData()
    }
        
    func clearPhotoDictionary() {
        self.drawingImages.removeAllObjects()
    }
}

extension PublicListVC: GetDrawingDataDelegate {
    /**
     Updates the table once the data is pulled from the database
     
     - Parameter jobData: An array that holds all of the job data pulled from the database
     */
    func updateData(data: [DrawingDataModel]) {
        clearDrawingDataArray()
        // Append the drawing data into the dictionary
        drawingData.append(contentsOf: data)
        self.drawingImages.removeAllObjects()
    }
    /// Clears all data from the holdData array
    func clearDrawingDataArray() {
        drawingData.removeAll()
    }
    /// Reloads the table
    func reloadTable() {
        collectionView.reloadData()
    }
}

