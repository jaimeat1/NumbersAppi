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
    
    @IBOutlet fileprivate var contact: UIButton!
    @IBOutlet fileprivate var basedOn: UILabel!
    @IBOutlet fileprivate var numbersApiLink: UIButton!
    @IBOutlet fileprivate var version: UILabel!
    
    let numbersApiAddress = "http://numbersapi.com"
    
    var presenterDelegate: AboutPresenterDelegate!
    
    // MARK: Lifecycle methods
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        setupView()
        localizeTexts()
    }
    
    // MARK: Action methods
    
    @IBAction func doneButtonPressed() {
        
        presenterDelegate.doneButtonPressed()
    }
    
    @IBAction func linkButtonPressed() {
        
        presenterDelegate.linkButtonPressed()
    }
    
    @IBAction func contactButtonPressed() {
        
        presenterDelegate.contactButtonPressed()
    }
    
    // MARK: Private methods
    
    fileprivate func setupView() {
        
        view.backgroundColor = UIColor.clear
        view.tintColor = UIColor.black

        basedOn.font = UIFont.numbersNormalFontOfSize(18)
        basedOn.textColor = UIColor.darkGray
        
        let attributesNormal = [NSFontAttributeName: UIFont.numbersResponseFontOfSize(22),
                          NSForegroundColorAttributeName: UIColor.darkGray,
                          NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue] as [String : Any]
        let attributedNormal = NSAttributedString(string: numbersApiAddress, attributes: attributesNormal);
        
        let attributesPressed = [NSFontAttributeName: UIFont.numbersResponseFontOfSize(22),
                          NSForegroundColorAttributeName: UIColor.white,
                          NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue] as [String : Any]
        let attributedPressed = NSAttributedString(string: numbersApiAddress, attributes: attributesPressed);
        
        numbersApiLink.setAttributedTitle(attributedNormal, for: UIControlState())
        numbersApiLink.setAttributedTitle(attributedPressed, for: UIControlState.highlighted)
        numbersApiLink.setAttributedTitle(attributedPressed, for: UIControlState.focused)
        
        version.font = UIFont.numbersNormalFontOfSize(14)
        version.textColor = UIColor.gray
    }
    
    fileprivate func localizeTexts() {
        
        let contactMe = NSLocalizedString("CONTACT", comment: "Contact button")
        contact.setTitle(contactMe, for: UIControlState())
        basedOn.text = NSLocalizedString("BASED_ON", comment: "Based on description")
        let versionNumber = presenterDelegate.getVersion()
        let versionDesc = NSLocalizedString("VERSION", comment: "Version title")
        version.text = versionDesc + " " + versionNumber
    }
}
