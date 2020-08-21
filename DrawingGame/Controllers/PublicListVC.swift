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
    
   /* func presentPopUpVC (popUpVC : UIViewController) {
        // Animation customized in the TutoringJobDetailsVC
        popUpVC.modalPresentationStyle = .custom
        popUpVC.preferredContentSize = CGSize(width:500,height:600) //manage according to Device like iPad/iPhone
        let popover = popUpVC.popoverPresentationController
        
        popover?.delegate = self
        popover?.sourceView = self.view
        popover?.sourceRect = CGRect(x: view.center.x, y: view.center.y, width: 0, height: 0)
        popover?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        
        self.present(popUpVC, animated: true, completion: nil)
        
    } */
        
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
        
       // self.drawingData[indexPath.row].getDocId()
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
    // When a drawing is selected, display the drawing details pop up and pass in the data
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // guard let cell = collectionView.cellForItem(at: indexPath) else { return }

        let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "drawingDetailsId") as! DrawingDetailsVC
        popUpVC.drawingData = self.drawingData[indexPath.row]
        PresentPopUpVC.presentPopUp(popUpVC: popUpVC, presentingVC: self)        
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

