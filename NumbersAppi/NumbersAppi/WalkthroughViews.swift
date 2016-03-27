//
//  Walkthrough.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 27/03/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation
import UIKit

struct WalkthroughViews {
    
    let animationDuration = 0.5
    let maximumSize: CGFloat = 150
    let minimumAlpha: CGFloat = 0.5
    
    private var textResult: UILabel
    private var shadowView: UIView
    private var singleTapView: UIView
    private var singleTapInfo: UILabel
    private var singleTapImage: UIImageView
    private var doubleTapView: UIView
    private var doubleTapInfo: UILabel
    private var doubleTapImage: UIImageView
    
    private var timer: NSTimer?
    
    // MARK: - Lifecycle methods
    
    init(textResult: UILabel,
        shadowView: UIView,
        singleTapView: UIView,
        singleTapInfo: UILabel,
        singleTapImage: UIImageView,
        doubleTapView: UIView,
        doubleTapInfo: UILabel,
        doubleTapImage: UIImageView) {

            self.textResult = textResult
            self.shadowView = shadowView
            self.singleTapView = singleTapView
            self.singleTapInfo = singleTapInfo
            self.singleTapImage = singleTapImage
            self.doubleTapView = doubleTapView
            self.doubleTapInfo = doubleTapInfo
            self.doubleTapImage = doubleTapImage
    }
    
    // MARK: - Public methods
    
    func hide() {
        
        self.shadowView.hidden = true
        self.singleTapView.hidden = true
        self.singleTapInfo.hidden = true
        self.singleTapImage.hidden = true
        self.doubleTapView.hidden = true
        self.doubleTapInfo.hidden = true
        self.doubleTapView.hidden = true
    }
    
    mutating func showSingleTapWalkthrough() {
        
        self.shadowView.hidden = false
        
        self.singleTapView.hidden = false
        self.singleTapInfo.hidden = false
        self.singleTapImage.hidden = false
        
        startSingleTapAnimation()
    }
    
    mutating func showDoubleTapWalkthrough() {
        
        self.singleTapView.hidden = true
        self.singleTapInfo.hidden = true
        self.singleTapImage.hidden = true
        
        self.doubleTapView.hidden = false
        self.doubleTapInfo.hidden = false
        self.doubleTapView.hidden = false
        
        timer?.invalidate()
        startDoubleTapAnimation()
    }
    
    func getSingleTapViews() -> [UIView] {
        
        return [textResult, shadowView, singleTapView, singleTapInfo, singleTapImage]
    }
    
    func getDoubleTapViews() -> [UIView] {
    
        return [textResult, shadowView, doubleTapView, doubleTapInfo, doubleTapImage]
    }
    
    func setSingleInfoText(text: String) {

        singleTapInfo.text = text
    }
    
    func setDoubleInfoText(text: String) {
        
        doubleTapInfo.text = text
    }
    
    // MARK: Private methods
    
    mutating private func startSingleTapAnimation() {
        
        let imageToAnimate = UIImageView(frame: singleTapImage.frame)
        imageToAnimate.image = singleTapImage.image
        singleTapView.addSubview(imageToAnimate)
        
        let increaseSizeAnimation: () -> Void = {
            
            imageToAnimate.alpha = 1
            imageToAnimate.frame.size.width = self.maximumSize
            imageToAnimate.frame.size.height = self.maximumSize
            imageToAnimate.center = self.singleTapImage.center
            imageToAnimate.alpha = self.minimumAlpha
        }
        
        let standForAWhileAnimation: () -> Void = {
            
            UIView.animateWithDuration(self.animationDuration,
                animations: { () -> Void in
                    imageToAnimate.alpha = 0
                },
                completion: { (Bool) -> Void in
                    imageToAnimate.center = self.singleTapImage.center
                    imageToAnimate.frame.size.width = self.singleTapImage.frame.size.width
                    imageToAnimate.frame.size.height = self.singleTapImage.frame.size.height
            })
        }
    
        let beatAnimation: () -> Void = {
            
            UIView.animateWithDuration(self.animationDuration,
                animations: {
                    increaseSizeAnimation()
                },
                completion: { finished in
                    standForAWhileAnimation()
                }
            )
        }
 
        timer = NSTimer.scheduledTimerWithTimeInterval(2.0,
            block: { () -> Void in
                beatAnimation()
            }, repeats: true) as? NSTimer
    }
    
    private func startDoubleTapAnimation() {
        
    }
}