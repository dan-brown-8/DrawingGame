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
    
    // Load in data and store into the collection data array
    var collectionData = ["test1", "test2", "test3", "test4", "test5", "test6", "test7", "test8", "test9", "test10", "test11", "test12"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = (view.frame.size.width - 20) / 3
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width) 
        // Do any additional setup after loading the view.
    }
}
    
    extension PublicListVC: UICollectionViewDelegate, UICollectionViewDataSource {

        func numberOfSections(in collectionView: UICollectionView) -> Int {
          return 1
        }
        
        //2
        func collectionView(_ collectionView: UICollectionView,
                                     numberOfItemsInSection section: Int) -> Int {
            return collectionData.count
        }
        
        //3
        func collectionView(
          _ collectionView: UICollectionView,
          cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! DrawingCollectionViewCell
            
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
