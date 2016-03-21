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
    
    @IBOutlet private var basedOn: UILabel!
    @IBOutlet private var numbersApiLink: UILabel!
    @IBOutlet private var version: UILabel!
    @IBOutlet private var likeIt: UILabel!
    @IBOutlet private var contact: UIButton!
    
    let numbersApiAddress = "numbersapi.com"
    
    var presenterDelegate: AboutPresenterDelegate!
    
    // MARK: Lifecycle methods
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        localizeTexts()
    }
    
    // MARK: Action methods
    
    @IBAction func backButtonPressed() {
        
        presenterDelegate.backButtonPressed()
    }
    
    // MARK: Private methods
    
    private func localizeTexts() {
        
        basedOn.text = NSLocalizedString("BASED_ON", comment: "Based on description")
        numbersApiLink.text = numbersApiAddress
        likeIt.text = NSLocalizedString("LIKE_IT", comment: "Like or comments description")
        version.text = presenterDelegate.getVersion()
        let contactMe = NSLocalizedString("CONTACT_ME", comment: "Contact button")
        contact.setTitle(contactMe, forState: UIControlState.Normal)
    }
}