//
//  PresentPopUpVC.swift
//  DrawingGame
//
//  Created by Dan Brown on 8/21/20.
//  Copyright © 2020 Dan Brown. All rights reserved.
//

import UIKit

class PresentPopUpVC {
    
    static func presentPopUp(popUpVC : UIViewController, presentingVC: UIViewController) {

        popUpVC.modalPresentationStyle = .custom
        popUpVC.preferredContentSize = CGSize(width:500,height:600) //manage according to Device like iPad/iPhone
        let popover = popUpVC.popoverPresentationController
        
        popover?.delegate = (presentingVC as! UIPopoverPresentationControllerDelegate)
        popover?.sourceView = presentingVC.view
        popover?.sourceRect = CGRect(x: presentingVC.view.center.x, y: presentingVC.view.center.y, width: 0, height: 0)
        popover?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        
        presentingVC.present(popUpVC, animated: true, completion: nil)
        
    }
}
