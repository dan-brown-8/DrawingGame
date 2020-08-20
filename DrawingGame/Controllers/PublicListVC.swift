//
//  PublicListVC.swift
//  DrawingGame
//
//  Created by Dan Brown on 8/19/20.
//  Copyright © 2020 Dan Brown. All rights reserved.
//

import UIKit

class PublicListVC: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    @IBOutlet var publicListView: PublicListView!
    
    /// The thumbnail images of the drawings. Parallel array with 'drawingData'
    var drawingImages = [UIImage]()
    
    /// The data that corresponds with the drawings.  Parallel array with 'drawingImages'
    var drawingData : [DrawingDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = (view.frame.size.width - 20) / 3
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
        configureNavigationBar()
        populateDrawingPhotos()
        
    }
    
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
        
    // Handle what happens when the 'New +' button is pressed, sho
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
            
        cell.drawingImage.image = self.drawingImages[indexPath.row]
           // cell.drawingLabel.text = collectionData[indexPath.row]
            // TODO: Load drawing image into cell
         //   cell.drawingImage.
            
          /*  if let label = cell.viewWithTag(100) as? UILabel {
                label.text = collectionData[indexPath.row]
            } */
            
          //  cell.backgroundColor = .blue
          // Configure the cell
        return cell
    }    


}

extension PublicListVC: GetPhotoDelegate {
    /// Protocol that receives the downloaded photo
    func getPhoto(data: Data) {
        self.drawingImages.append(UIImage(data: data)!)
        collectionView.reloadData()
      // print(self.collectionData)
    }
    
    //func updateImages(image: Data, index: Int) {}
    
    func clearPhotoArray() {
        self.drawingImages.removeAll()
    }
}

extension PublicListVC: GetDrawingDataDelegate {
    /**
     Updates the table once the data is pulled from the database
     
     - Parameter jobData: An array that holds all of the job data pulled from the database
     */
    func updateData(data: [DrawingDataModel]) {
        clearDrawingDataArray()
        // Append the drawing data into the array
        drawingData.append(contentsOf: data)
        //print(data[0].getArtist())
        //print(data[1].getDisplayName())
        self.drawingImages.removeAll()
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

