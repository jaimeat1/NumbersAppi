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
    
    func didRequestNumber(_ number: Int, ofType type: ApiRequestType)

    func didRequestDate(month: Int, day: Int)
    
    func didRequestRandomNumberWithType(_ type: ApiRequestType)
    
    func didRequestRandomDate()
    
    func userSelectedAbout()
    
    func shouldShowPullableInformation() -> Bool
    
    func shouldShowWalkthrough() -> Bool
}

class MainPresenter: MainPresenterDelegate {
    
    let showPullable = "showPullable"
    let walkthroughWasShown = "walkthroughWasShown"

    var controllerDelegate: MainViewControllerDelegate
    
    // MARK: - Lifecycle methods
    
    init(controllerDelegate: MainViewControllerDelegate) {
        
        self.controllerDelegate = controllerDelegate
    }
    
    // MARK: - MainPresenterDelegate methods
    
    func userSelectedAbout() {
        
        Coordinator.sharedInstance.presentAboutFromMain()
    }

    func didRequestNumber(_ number: Int, ofType type: ApiRequestType) {

        let request = ApiRequest(type: type, number: number)
        launchAndHandleApiRequest(request)
    }

    func didRequestDate(month: Int, day: Int) {

        let request = ApiRequest(month: month, day: day)
        launchAndHandleApiRequest(request)
    }

    func didRequestRandomNumberWithType(_ type: ApiRequestType) {

        let request =  ApiRequest(type: type)
        launchAndHandleRandomApiRequest(request)
    }
    
    func shouldShowPullableInformation() -> Bool {
        
        let userDefaults = UserDefaults.standard
        let shouldShowPullable = userDefaults.bool(forKey: showPullable)
        userDefaults.set(false, forKey: showPullable)
        
        return shouldShowPullable
    }
    
    func shouldShowWalkthrough() -> Bool {
        
        let userDefaults = UserDefaults.standard
        let viewInfoAlreadyShown = userDefaults.bool(forKey: walkthroughWasShown)
        
        if viewInfoAlreadyShown {
            
            return false
            
        } else {
            
            userDefaults.set(true, forKey: walkthroughWasShown)
            userDefaults.set(true, forKey: showPullable)
            return true
        }
    }
    
    func didRequestRandomDate() {
        
        let request =  ApiRequest(type: ApiRequestType.date)
        launchAndHandleRandomApiRequest(request)
    }
    
    // MARK: - Private methods
    
    fileprivate func launchAndHandleRandomApiRequest(_ request: ApiRequest) {
        
        controllerDelegate.startLoading()
        
        ApiServices.sharedInstance.sendRequest(request) { (response, error) -> Void in
            
            self.controllerDelegate.stopLoading()
            self.handleRandomApiResponse(response, error: error)
        }
    }
    
    fileprivate func handleRandomApiResponse(_ response: ApiResponse, error: NSError?) {
        
        if error != nil {
            
            let message = NSLocalizedString("ERROR", comment: "Error message")
            controllerDelegate.showErrorMessage(message)
            
        } else {
            
            controllerDelegate.showTextResponse(response.text)
            
            if response.type == ApiRequestType.date {

                let date = getMonthAndDayFromDayOfTheYear(response.number)
                controllerDelegate.setDate(month: date.month, day: date.day)
                
            } else {
                
                controllerDelegate.setNumber(response.number)
            }
        }
    }
    
    fileprivate func launchAndHandleApiRequest(_ request: ApiRequest) {
        
        controllerDelegate.startLoading()
        
        ApiServices.sharedInstance.sendRequest(request) { (response, error) -> Void in
            
            self.controllerDelegate.stopLoading()
            self.handleApiResponse(response, error: error)
        }
    }
    
    fileprivate func handleApiResponse(_ response: ApiResponse, error: NSError?) {
        
        if error != nil {
            
            let message = NSLocalizedString("ERROR", comment: "Error message")
            controllerDelegate.showErrorMessage(message)
            
        } else {
            
            controllerDelegate.showTextResponse(response.text)
        }
    }
    
    fileprivate func getMonthAndDayFromDayOfTheYear(_ dayOfYear: Int) -> (month: Int, day: Int) {
        
        let daysInMonths = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        
        var day = 1
        var month = 1
        var newDayOfYear = dayOfYear
        for daysInCurrentMonth in daysInMonths {
            
            if ((newDayOfYear - daysInCurrentMonth) <= 0) {
                day = newDayOfYear
                break
            } else {
                newDayOfYear = newDayOfYear - daysInCurrentMonth
                month += 1
            }
        }
        
        return (month, day)
    }
}
