//
//  AboutPresenter.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 20/02/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation

class AboutPresenter: AboutPresenterDelegate {
    
    var controllerDelegate: AboutViewControllerDelegate
    
    // MARK: - Lifecycle methods
    
    init(controllerDelegate: AboutViewControllerDelegate) {
        
        self.controllerDelegate = controllerDelegate
    }
    
    // MARK: - AboutPresenterDelegate methods
    
    func backButtonPressed() {
        
        Coordinator.sharedInstance.presentMainFromAbout()
    }
}