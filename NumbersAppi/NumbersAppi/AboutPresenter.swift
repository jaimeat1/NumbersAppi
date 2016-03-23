//
//  AboutPresenter.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 20/02/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation
import UIKit

class AboutPresenter: AboutPresenterDelegate {
    
    private let linkAddress = "http://numbersapi.com"
    
    var controllerDelegate: AboutViewControllerDelegate
    
    // MARK: - Lifecycle methods
    
    init(controllerDelegate: AboutViewControllerDelegate) {
        
        self.controllerDelegate = controllerDelegate
    }
    
    // MARK: - AboutPresenterDelegate methods
    
    func backButtonPressed() {
        
        Coordinator.sharedInstance.presentMainFromAbout()
    }
    
    func linkButtonPressed() {
        
        UIApplication.sharedApplication().openURL(NSURL(string: linkAddress)!)
    }
    
    func getVersion() -> String {
        
        return (NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as? String)!
    }
    
}