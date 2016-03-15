//
//  AboutViewController.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 14/02/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation
import UIKit

class AboutViewController: UIViewController, AboutViewControllerDelegate {
    
    var presenterDelegate: AboutPresenterDelegate!
    
    // MARK: Action methods
    
    @IBAction func backButtonPressed() {
        
        presenterDelegate.backButtonPressed()
    }
}