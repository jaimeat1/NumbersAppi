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
   
    // MARK: Lifecyle methods
    
    init() {
        
        mainViewController = MainViewController()
        mainPresenter = MainPresenter(controllerDelegate: mainViewController)
        mainViewController.presenterDelegate = mainPresenter
    }
    
    // MARK: Public methods
    
    func getMainViewController() -> UIViewController {
        
        return mainViewController
    }
}