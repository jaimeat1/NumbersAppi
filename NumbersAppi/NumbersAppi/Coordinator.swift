//
//  Coordinator.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 20/02/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation
import UIKit

class Coordinator {
    
    static let sharedInstance = Coordinator()
    
    private var mainPresenter: MainPresenter
    private var mainViewController: MainViewController
    private var aboutPresenter: AboutPresenter
    private var aboutViewController: AboutViewController
   
    // MARK: Lifecyle methods
    
    init() {
        
        mainViewController = MainViewController()
        mainPresenter = MainPresenter(controllerDelegate: mainViewController)
        mainViewController.presenterDelegate = mainPresenter
        
        aboutViewController = AboutViewController()
        aboutPresenter = AboutPresenter(controllerDelegate: aboutViewController)
        aboutViewController.presenterDelegate = aboutPresenter
    }
    
    // MARK: Public methods
    
    func getMainViewController() -> UIViewController {
        
        return mainViewController
    }
    
    func presentAboutFromMain() {
        
        mainViewController.presentViewController(aboutViewController, animated: true, completion: nil)
    }
    
    func presentMainFromAbout() {
        
        mainViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}