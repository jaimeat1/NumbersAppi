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

    private let maxPullableDistance: CGFloat = 80.0
    private let animationDuration: NSTimeInterval = 0.3
    private let showPullableDuration: NSTimeInterval = 2.0
    private let minimunAlpha: CGFloat = 0.8
    private let factorToShowTranslucentView: CGFloat = 0.90
    
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

        self.translucentView.alpha = minimunAlpha
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
    
    func showPullable() {
        
        pointOfOrigin = CGPoint(x: 0, y: 0)
        pullableView.frame.origin.y = maxPullableDistance
        translucentView.alpha = 0

        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(showPullableDuration * Double(NSEC_PER_SEC)))
        dispatch_after(dispatch_time_t(delayTime), dispatch_get_main_queue()) { () -> Void in
            
            self.animatePullableViewToOrigin()
            self.animateTranslucentViewHiding()
        }
    }
    
    // MARK: - Action methods

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

                    if translucentViewShouldBeVisible() {
                        animateTranslucentViewShowing()
                    }
                }
            
            case UIGestureRecognizerState.Ended:
            
                if hasReachedMaximumDistance() {
                    delegate?.viewWasPulled()
                }
            
                animatePullableViewToOrigin()
                animateTranslucentViewHiding()
            
            default: ()
        }
    }
    
    func hasReachedMaximumDistance() -> Bool {
        
        if let yOrigin = pointOfOrigin?.y {
            
            let distance = abs(yOrigin - pullableView.frame.origin.y)
            if (distance > maxPullableDistance) {
                return true
            }
        }
        
        return false
    }
    
    // MARK: - Private methods
    
    private func setupDragGesture() {

        if !isAlreadySetup {
        
            isAlreadySetup = true
            let panGesture = UIPanGestureRecognizer.init(target: self, action: "didDraggView:")
            pullableView.addGestureRecognizer(panGesture)
        }
    }
    
    private func animatePullableViewToOrigin() {
        
        UIView.animateWithDuration(animationDuration, animations: { () -> Void in
            
            if let yOrigin = self.pointOfOrigin?.y {
                self.pullableView.frame.origin.y = yOrigin
            }
        })
    }
    
    private func animateTranslucentViewHiding() {
        
        UIView.animateWithDuration(animationDuration, animations: { () -> Void in
            self.translucentView.alpha = self.minimunAlpha;
        })
    }
    
    private func animateTranslucentViewShowing() {
        
        UIView.animateWithDuration(animationDuration, animations: { () -> Void in
            self.translucentView.alpha = 0;
        })
    }
    
    private func translucentViewShouldBeVisible() -> Bool {
        
        let distance = (pullableView.frame.origin.y - pointOfOrigin!.y)
        return (distance >= (maxPullableDistance * factorToShowTranslucentView))
    }
}