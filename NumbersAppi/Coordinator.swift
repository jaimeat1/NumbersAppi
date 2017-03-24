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
    
    fileprivate var mainPresenter: MainPresenter
    fileprivate var mainViewController: MainViewController
    fileprivate var aboutPresenter: AboutPresenter
    fileprivate var aboutViewController: AboutViewController
   
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
        
        mainViewController.present(aboutViewController, animated: true, completion: nil)
    }
    
    func presentMainFromAbout() {
        
        mainViewController.dismiss(animated: true, completion: nil)
    }
}
