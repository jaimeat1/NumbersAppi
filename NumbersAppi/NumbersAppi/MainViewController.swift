//
//  MainViewController.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 14/02/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation
import UIKit

protocol MainViewProtocol {
    
    func startLoading()
    
    func stopLoading()
    
    func showText(text: String)
    
    func setNumber(number: Int)
    
    func setDate(month month: Int, day: Int)
    
    func showWalkthrough()
    
    func didViewLayout()
}

class MainViewController: UIViewController, MainViewControllerDelegate, PullControllerDelegate, MainViewDelegate {

    @IBOutlet private var mainView: MainView!
    @IBOutlet private var aboutLabel: UILabel!
    
    var presenterDelegate: MainPresenterDelegate!
    
    private var pullController: PullController?
    
    // MARK: - Lifecycle methods
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        mainView.delegate = self
        pullController = PullController(pullableView: mainView, translucentView: aboutLabel, delegate: self)
        aboutLabel.text = NSLocalizedString("PULL_ABOUT", comment: "Pull to see about")
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)

        if presenterDelegate.shouldShowWalkthrough() {
            
            mainView.showWalkthrough()
            
        } else if presenterDelegate.shouldShowPullableInformation() {
            
            pullController?.showPullable()
            mainView.didViewLayout()
        }
    }
    
    // MARK: - MainViewControllerDelegate methods
    
    func startLoading() {
        
        mainView.startLoading()
    }
    
    func stopLoading() {
        
        mainView.stopLoading()
    }
    
    func showErrorMessage(message: String) {
        
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let accept = NSLocalizedString("ACCEPT", comment: "Accept button")
        alert.addAction(UIAlertAction(title: accept, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func showTextResponse(text: String) {
        
        mainView.showText(text)
    }
    
    func setNumber(number: Int) {

        mainView.setNumber(number)
    }
    
    func setDate(month month: Int, day: Int) {
        
        mainView.setDate(month: month, day: day)
    }
    
    // MARK: - PullControllerDelegate methods
    
    func viewWasPulled() {
        
        presenterDelegate?.userSelectedAbout()
    }
    
    // MARK: - MainViewDelegate methods

    func didRequestNumber(number: Int, ofType type: ApiRequestType) {
        
        presenterDelegate.didRequestNumber(number, ofType: type)
    }
    
    func didRequestDate(month month: Int, day: Int) {
        
        presenterDelegate.didRequestDate(month: month, day: day)
    }
    
    func didRequestRandomNumberWithType(type: ApiRequestType) {
        
        presenterDelegate.didRequestRandomNumberWithType(type)
    }
    
    func didRequestRandomDate() {
        
        presenterDelegate.didRequestRandomDate()
    }
    
    func didHideWalkthrough() {
        
        pullController?.enablePullable()
    }
}