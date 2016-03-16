//
//  MainPresenter.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 14/02/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation

// TODO: declare protocols in the same file (I think it's better, in this way protocol and class that expects it are linked)
// TODO: share ApiRequestType among presenter, view controller and views? isn't it against rigth hierarchy?

protocol MainPresenterDelegate {
    
    func didRequestNumber(number: Int, ofType type: ApiRequestType)

    func didRequestDate(month month: Int, day: Int)
    
    func didRequestRandomNumberWithType(type: ApiRequestType)
    
    func didRequestRandomDate()
    
    func userSelectedAbout()
}

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
    
    func didRequestNumber(number: Int, ofType type: ApiRequestType) {

        controllerDelegate.startLoading()
        
        let request = ApiRequest(type: type, number: number)
        
        ApiServices.sharedInstance.sendRequest(request) { (response, error) -> Void in
            
            self.controllerDelegate.stopLoading()
            
            if error != nil {
                
                self.controllerDelegate.showErrorMessage("")
                
            } else {

                self.controllerDelegate.showTextResponse(response.text)
            }
        }
    }
    
    func didRequestDate(month month: Int, day: Int) {
        
    }
    
    func didRequestRandomNumberWithType(type: ApiRequestType) {
        
    }
    
    func didRequestRandomDate() {
        
    }
}