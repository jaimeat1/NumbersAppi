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
}

class MainViewController: UIViewController, MainViewControllerDelegate, PullControllerDelegate, MainViewDelegate {

    @IBOutlet private var mainView: MainView!
    @IBOutlet private var aboutLabel: UILabel!
    @IBOutlet private var fadingView: UIView!
    
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
        pullController = PullController(pullableView: mainView, translucentView: fadingView, delegate: self)
    }
    
    // MARK: - MainViewControllerDelegate methods
    
    func startLoading() {
        
        mainView.startLoading()
    }
    
    func stopLoading() {
        
        mainView.stopLoading()
    }
    
    func showErrorMessage(message: String) {
        
        // TODO: show error
    }
    
    func showTextResponse(text: String) {
        
        mainView.showText(text)
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
}