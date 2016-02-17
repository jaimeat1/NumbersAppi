//
//  MainViewController.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 14/02/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController, MainViewControllerDelegate, PullControllerDelegate {

    @IBOutlet private var mainView: MainView!
    @IBOutlet private var aboutLabel: UILabel!
    
    var presenterDelegate: MainPresenterDelegate?
    
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
        
        pullController = PullController(pullableView: mainView, translucentView: aboutLabel, delegate: self)
    }
    
    // MARK: - MainViewControllerDelegate methods
    
    // MARK: - PullControllerDelegate methods
    
    func viewWasPulled() {
        
        presenterDelegate?.userSelectedAbout()
    }
}