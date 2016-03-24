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
    
    func shouldShowPullableInformation() -> Bool
}

class MainPresenter: MainPresenterDelegate {
    
    let pullableWasShown = "pullableWasShown"

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

        let request = ApiRequest(type: type, number: number)
        launchAndHandleApiRequest(request)
    }

    func didRequestDate(month month: Int, day: Int) {

        let request = ApiRequest(month: month, day: day)
        launchAndHandleApiRequest(request)
    }

    func didRequestRandomNumberWithType(type: ApiRequestType) {

        let request =  ApiRequest(type: type)
        launchAndHandleRandomApiRequest(request)
    }
    
    func shouldShowPullableInformation() -> Bool {
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let pullableAlreadyShown = userDefaults.boolForKey(pullableWasShown)
        
        if pullableAlreadyShown {
            
            return false
            
        } else {
            
            userDefaults.setBool(true, forKey: pullableWasShown)
            return true
        }
    }
    
    func didRequestRandomDate() {
        
        let request =  ApiRequest(type: ApiRequestType.Date)
        launchAndHandleRandomApiRequest(request)
    }
    
    // MARK: - Private methods
    
    private func launchAndHandleRandomApiRequest(request: ApiRequest) {
        
        controllerDelegate.startLoading()
        
        ApiServices.sharedInstance.sendRequest(request) { (response, error) -> Void in
            
            self.controllerDelegate.stopLoading()
            self.handleRandomApiResponse(response, error: error)
        }
    }
    
    private func handleRandomApiResponse(response: ApiResponse, error: NSError?) {
        
        if error != nil {
            
            let message = NSLocalizedString("ERROR", comment: "Error message")
            controllerDelegate.showErrorMessage(message)
            
        } else {
            
            controllerDelegate.showTextResponse(response.text)
            
            if response.type == ApiRequestType.Date {

                let date = getMonthAndDayFromDayOfTheYear(response.number)
                controllerDelegate.setDate(month: date.month, day: date.day)
                
            } else {
                
                controllerDelegate.setNumber(response.number)
            }
        }
    }
    
    private func launchAndHandleApiRequest(request: ApiRequest) {
        
        controllerDelegate.startLoading()
        
        ApiServices.sharedInstance.sendRequest(request) { (response, error) -> Void in
            
            self.controllerDelegate.stopLoading()
            self.handleApiResponse(response, error: error)
        }
    }
    
    private func handleApiResponse(response: ApiResponse, error: NSError?) {
        
        if error != nil {
            
            let message = NSLocalizedString("ERROR", comment: "Error message")
            controllerDelegate.showErrorMessage(message)
            
        } else {
            
            controllerDelegate.showTextResponse(response.text)
        }
    }
    
    private func getMonthAndDayFromDayOfTheYear(var dayOfYear: Int) -> (month: Int, day: Int) {
        
        let daysInMonths = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        
        var day = 1
        var month = 1
        for daysInCurrentMonth in daysInMonths {
            
            if ((dayOfYear - daysInCurrentMonth) <= 0) {
                day = dayOfYear
                break
            } else {
                dayOfYear = dayOfYear - daysInCurrentMonth
                month++
            }
        }
        
        return (month, day)
    }
}