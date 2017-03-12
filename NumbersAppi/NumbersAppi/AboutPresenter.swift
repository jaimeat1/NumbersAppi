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
    
    fileprivate let linkAddress = "http://numbersapi.com"
    fileprivate let contactAddress = "jaime.aranaz@gmail.com"
    
    var controllerDelegate: AboutViewControllerDelegate
    
    // MARK: - Lifecycle methods
    
    init(controllerDelegate: AboutViewControllerDelegate) {
        
        self.controllerDelegate = controllerDelegate
    }
    
    // MARK: - AboutPresenterDelegate methods
    
    func doneButtonPressed() {
        
        Coordinator.sharedInstance.presentMainFromAbout()
    }
    
    func linkButtonPressed() {
        
        UIApplication.shared.openURL(URL(string: linkAddress)!)
    }
    
    func contactButtonPressed() {
        
        let mailto = URL(string: "mailto:\(contactAddress)")
        UIApplication.shared.openURL(mailto!)
    }
    
    func getVersion() -> String {
        
        return (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String)!
    }
    
}
