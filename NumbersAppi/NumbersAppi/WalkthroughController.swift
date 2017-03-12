//
//  MainViewInfo.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 24/03/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation
import UIKit
import NSTimer_Blocks

protocol WalkthroughControllerDelegate {
    
    func didDismissWalkthrough()
}

class WalkthroughController {
    
    fileprivate var delegate: WalkthroughControllerDelegate!
    fileprivate var walkthroughViews: WalkthroughViews
    fileprivate var singleViews: [UIView]!
    fileprivate var doubleViews: [UIView]!
 
    // MARK: Lifecycle methods
    
    init(walkthroughViews: WalkthroughViews, delegate: WalkthroughControllerDelegate) {
        
        self.walkthroughViews = walkthroughViews
        self.delegate = delegate
        
        singleViews = walkthroughViews.getSingleTapViews()
        doubleViews = walkthroughViews.getDoubleTapViews()
        
        localizeTexts()
    }
    
    // MARK: Public methods
    
    func show() {
        
        walkthroughViews.hide()
        walkthroughViews.showSingleTapWalkthrough()
        addTapGestureForSingleView()
    }
    
    // MARK: Action methods
    
    @objc func didTapWithSingleViewShowing() {
        
        walkthroughViews.showDoubleTapWalkthrough()
        removeTapGestureForSingleView()
        addTapGestureForDoubleView()
    }
    
    @objc func didTapWithDoubleViewShowing() {
        
        walkthroughViews.hide()
        removeTapGestureForDoubleView()
        delegate.didDismissWalkthrough()
    }
    
    // MARK: Private methods
    
    fileprivate func localizeTexts() {
        
        walkthroughViews.setSingleInfoText(NSLocalizedString("SINGLE_TAP", comment: "Description for single tap"))
        walkthroughViews.setDoubleInfoText(NSLocalizedString("DOUBLE_TAP", comment: "Description for double tap"))
    }
    
    fileprivate func addTapGestureForSingleView() {

        for oneView in singleViews {
            
            let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(WalkthroughController.didTapWithSingleViewShowing))
            oneView.addGestureRecognizer(tapGesture)
        }
    }
    
    fileprivate func addTapGestureForDoubleView() {

        for oneView in doubleViews {
            
            let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(WalkthroughController.didTapWithDoubleViewShowing))
            oneView.addGestureRecognizer(tapGesture)
        }
    }
    
    fileprivate func removeTapGestureForSingleView() {
        
        for oneView in singleViews {
            
            let tapGestures = oneView.gestureRecognizers
            oneView.removeGestureRecognizer(tapGestures![0])
        }
    }
    
    fileprivate func removeTapGestureForDoubleView() {
        
        for oneView in doubleViews {
            
            let tapGestures = oneView.gestureRecognizers
            oneView.removeGestureRecognizer(tapGestures![0])
        }
    }
    
}
