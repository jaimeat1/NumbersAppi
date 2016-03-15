//
//  MainPresenter.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 14/02/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation

class MainPresenter: MainPresenterDelegate {

    var controllerDelegate: MainViewControllerDelegate
    
    // MARK: - Lifecycle methods
    
    init(controllerDelegate: MainViewControllerDelegate) {
        
        self.controllerDelegate = controllerDelegate
    }
    
    // MARK: - MainPresenterDelegate methods
    
    func userSelectedAbout() {
        
        Coordinator.sharedInstance.presentAboutFromMain()
    }
    
    func didRequestNumber(number: Int) {
        
    }
    
    func didRequestDate(month month: Int, day: Int) {
        
    }
    
    func didRequestRandomNumber() {
        
    }
    
    func didRequestRandomDate() {
        
    }
}