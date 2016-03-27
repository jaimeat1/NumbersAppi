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
    
    private var delegate: WalkthroughControllerDelegate!
    private var walkthroughViews: WalkthroughViews
    private var singleViews: [UIView]!
    private var doubleViews: [UIView]!
 
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
    
    @IBAction func didTapWithSingleViewShowing() {
        
        walkthroughViews.showDoubleTapWalkthrough()
        removeTapGestureForSingleView()
        addTapGestureForDoubleView()
    }
    
    @IBAction func didTapWithDoubleViewShowing() {
        
        walkthroughViews.hide()
        removeTapGestureForDoubleView()
        delegate.didDismissWalkthrough()
    }
    
    // MARK: Private methods
    
    private func localizeTexts() {
        
        walkthroughViews.setSingleInfoText(NSLocalizedString("SINGLE_TAP", comment: "Description for single tap"))
        walkthroughViews.setDoubleInfoText(NSLocalizedString("DOUBLE_TAP", comment: "Description for double tap"))
    }
    
    private func addTapGestureForSingleView() {

        for oneView in singleViews {
            
            let tapGesture = UITapGestureRecognizer.init(target: self, action: "didTapWithSingleViewShowing")
            oneView.addGestureRecognizer(tapGesture)
        }
    }
    
    private func addTapGestureForDoubleView() {

        for oneView in doubleViews {
            
            let tapGesture = UITapGestureRecognizer.init(target: self, action: "didTapWithDoubleViewShowing")
            oneView.addGestureRecognizer(tapGesture)
        }
    }
    
    private func removeTapGestureForSingleView() {
        
        for oneView in singleViews {
            
            let tapGestures = oneView.gestureRecognizers
            oneView.removeGestureRecognizer(tapGestures![0])
        }
    }
    
    private func removeTapGestureForDoubleView() {
        
        for oneView in doubleViews {
            
            let tapGestures = oneView.gestureRecognizers
            oneView.removeGestureRecognizer(tapGestures![0])
        }
    }
    
}