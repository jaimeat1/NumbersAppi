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

    fileprivate let maxPullableDistance: CGFloat = 80.0
    fileprivate let animationDuration: TimeInterval = 0.3
    fileprivate let showPullableDuration: TimeInterval = 1.0
    fileprivate let minimunAlpha: CGFloat = 0.3
    fileprivate let factorToShowTranslucentView: CGFloat = 0.90
    
    fileprivate var pullableView: UIView
    fileprivate var translucentView: UIView
    fileprivate var delegate: PullControllerDelegate?
    fileprivate var isAlreadySetup = false
    fileprivate var pointOfOrigin: CGPoint?
    fileprivate var pullGestureEnabled = true
    
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
        translucentView.alpha = 1

        let delayTime = DispatchTime.now() + Double((showPullableDuration * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) { () -> Void in
            
            self.animatePullableViewToOrigin()
            self.animateTranslucentViewHiding()
        }
    }
    
    // MARK: - Action methods

    @objc func didDraggView(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        if (!pullGestureEnabled) {
            return
        }
        
        let yDistance = gestureRecognizer.translation(in: pullableView).y

        switch(gestureRecognizer.state) {
            
            case UIGestureRecognizerState.began:
            
                pointOfOrigin = pullableView.frame.origin
            
            case UIGestureRecognizerState.changed:
            
                if (yDistance > 0) && (!hasReachedMaximumDistance()) {
                    
                    pullableView.frame.origin.y = (pointOfOrigin!.y + yDistance)

                    if translucentViewShouldBeVisible() {
                        animateTranslucentViewShowing()
                    }
                }
            
            case UIGestureRecognizerState.ended:
            
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
    
    fileprivate func setupDragGesture() {

        if !isAlreadySetup {
        
            isAlreadySetup = true
            let panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(PullController.didDraggView(_:)))
            pullableView.addGestureRecognizer(panGesture)
        }
    }
    
    fileprivate func animatePullableViewToOrigin() {
        
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            
            if let yOrigin = self.pointOfOrigin?.y {
                self.pullableView.frame.origin.y = yOrigin
            }
        })
    }
    
    fileprivate func animateTranslucentViewHiding() {
        
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            self.translucentView.alpha = self.minimunAlpha;
        })
    }
    
    fileprivate func animateTranslucentViewShowing() {
        
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            self.translucentView.alpha = 1;
        })
    }
    
    fileprivate func translucentViewShouldBeVisible() -> Bool {
        
        let distance = (pullableView.frame.origin.y - pointOfOrigin!.y)
        return (distance >= (maxPullableDistance * factorToShowTranslucentView))
    }
}
