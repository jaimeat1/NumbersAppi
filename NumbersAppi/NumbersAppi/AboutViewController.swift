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
    
    @IBOutlet private var contact: UIButton!
    @IBOutlet private var basedOn: UILabel!
    @IBOutlet private var numbersApiLink: UIButton!
    @IBOutlet private var version: UILabel!
    
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
    
    private func setupView() {
        
        view.backgroundColor = UIColor.clearColor()
        view.tintColor = UIColor.blackColor()

        basedOn.font = UIFont.numbersNormalFontOfSize(18)
        basedOn.textColor = UIColor.darkGrayColor()
        
        let attributesNormal = [NSFontAttributeName: UIFont.numbersResponseFontOfSize(22),
                          NSForegroundColorAttributeName: UIColor.darkGrayColor(),
                          NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue]
        let attributedNormal = NSAttributedString(string: numbersApiAddress, attributes: attributesNormal);
        
        let attributesPressed = [NSFontAttributeName: UIFont.numbersResponseFontOfSize(22),
                          NSForegroundColorAttributeName: UIColor.whiteColor(),
                          NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue]
        let attributedPressed = NSAttributedString(string: numbersApiAddress, attributes: attributesPressed);
        
        numbersApiLink.setAttributedTitle(attributedNormal, forState: UIControlState.Normal)
        numbersApiLink.setAttributedTitle(attributedPressed, forState: UIControlState.Highlighted)
        numbersApiLink.setAttributedTitle(attributedPressed, forState: UIControlState.Focused)
        
        version.font = UIFont.numbersNormalFontOfSize(14)
        version.textColor = UIColor.grayColor()
    }
    
    private func localizeTexts() {
        
        let contactMe = NSLocalizedString("CONTACT", comment: "Contact button")
        contact.setTitle(contactMe, forState: UIControlState.Normal)
        basedOn.text = NSLocalizedString("BASED_ON", comment: "Based on description")
        let versionNumber = presenterDelegate.getVersion()
        let versionDesc = NSLocalizedString("VERSION", comment: "Version title")
        version.text = versionDesc + " " + versionNumber
    }
}