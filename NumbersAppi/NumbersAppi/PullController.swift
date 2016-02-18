//
//  PullController.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 17/02/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation
import UIKit

class PullController {

    private let maxPullableDistance: CGFloat = 100.0
    private let animationDuration: NSTimeInterval = 0.3
    
    private var pullableView: UIView
    private var translucentView: UIView
    private var delegate: PullControllerDelegate?
    private var isAlreadySetup = false
    private var pointOfOrigin: CGPoint?
    private var pullGestureEnabled = true
    
    // MARK: - Lifecycle methods
    
    init(pullableView: UIView, translucentView: UIView, delegate: PullControllerDelegate) {
        
        self.pullableView = pullableView
        self.translucentView = translucentView
        self.delegate = delegate

        setupDragGesture()
    }
    
    // MARK: - Public methods
    
    func enablePullable() {
        
        pullGestureEnabled = true
    }
    
    func disablePullable() {
        
        pullGestureEnabled = false
        animatePullableViewToOrigin()
    }
    
    // MARK: - Action methods
    
    @IBAction func didTap() {
        
        delegate?.viewWasPulled()
    }
    
    @IBAction func didDraggView(gestureRecognizer: UIPanGestureRecognizer) {
        
        if (!pullGestureEnabled) {
            return
        }
        
        let yDistance = gestureRecognizer.translationInView(pullableView).y

        switch(gestureRecognizer.state) {
            
            case UIGestureRecognizerState.Began:
            
                pointOfOrigin = pullableView.frame.origin
            
            case UIGestureRecognizerState.Changed:
            
                if (yDistance > 0) && (!hasReachedMaximumDistance()) {
                    
                    pullableView.frame.origin.y = (pointOfOrigin!.y + yDistance)

                    // TODO: change alpha in translucentView
                }
            
            case UIGestureRecognizerState.Ended:
            
                if (hasReachedMaximumDistance()) {
                
                    delegate?.viewWasPulled()
                }
            
                animatePullableViewToOrigin()

                // TODO: animate pullable view to origin
            
            default: ()
        }
    }
    
    func hasReachedMaximumDistance() -> Bool {
        
        if let yOrigin = pointOfOrigin?.y {
            
            if (abs(yOrigin - pullableView.frame.origin.y) > maxPullableDistance) {
                return true
            }
        }
        
        return false
    }
    
    // MARK: - Private methods
    
    func setupDragGesture() {

        if (!isAlreadySetup) {
        
            isAlreadySetup = true
            let panGesture = UIPanGestureRecognizer.init(target: self, action: "didDraggView:")
            pullableView.addGestureRecognizer(panGesture)
        }
    }
    
    func animatePullableViewToOrigin() {
        
        UIView.animateWithDuration(animationDuration, animations: { () -> Void in
            
            if let yOrigin = self.pointOfOrigin?.y {
                self.pullableView.frame.origin.y = yOrigin
            }
        })
    }
}