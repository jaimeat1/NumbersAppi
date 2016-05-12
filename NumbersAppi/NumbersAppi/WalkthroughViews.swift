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
    
    let maximumSize: CGFloat = 150
    let minimumAlpha: CGFloat = 0.5
    
    private let fontSize: CGFloat = 20
    
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
            self.singleTapInfo.font = UIFont.numbersNormalFontOfSize(fontSize)
            
            self.singleTapImage = singleTapImage
            self.doubleTapView = doubleTapView
            
            self.doubleTapInfo = doubleTapInfo
            self.doubleTapInfo.font = UIFont.numbersNormalFontOfSize(fontSize)
            
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

        let singleBeatAnimation = beatAnimation(
            originalImage: singleTapImage,
            changeDuration: 0.3,
            standDuration: 0.3)
 
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0,
            block: { () -> Void in
                singleBeatAnimation()
            }, repeats: true) as? NSTimer
    }
    
    mutating private func startDoubleTapAnimation() {

        let firstBeatAnimation = beatAnimation(
            originalImage: doubleTapImage,
            changeDuration: 0.2,
            standDuration: 0.2)
        
        let secondBeatAnimation = beatAnimation(
            originalImage: doubleTapImage,
            changeDuration: 0.2,
            standDuration: 0.2)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0,
            block: { () -> Void in
                
                NSTimer.scheduledTimerWithTimeInterval(0,
                    block: { () -> Void in
                        firstBeatAnimation()
                    }, repeats: false) as? NSTimer
                
                NSTimer.scheduledTimerWithTimeInterval(0.3,
                    block: { () -> Void in
                        secondBeatAnimation()
                    }, repeats: false) as? NSTimer
                
            }, repeats: true) as? NSTimer
    }
    
    private func beatAnimation(originalImage originalImage: UIImageView, changeDuration: NSTimeInterval, standDuration: NSTimeInterval) -> () -> Void  {
        
        let imageToAnimate = UIImageView(frame: originalImage.frame)
        imageToAnimate.image = originalImage.image
        originalImage.superview?.addSubview(imageToAnimate)
        
        let singleIncreaseAnimation = increaseSizeAnimation(animatedView: imageToAnimate, originalCenter: originalImage.center)
        
        let singleStandAnimation = standForAWhileAnimation(
            animatedView: imageToAnimate,
            duration: standDuration,
            originalView: originalImage)
        
        let myBeatAnimation: () -> Void = {
            
            UIView.animateWithDuration(changeDuration,
                animations: {
                    singleIncreaseAnimation()
                },
                completion: { finished in
                    singleStandAnimation()
                }
            )
        }
        
        return myBeatAnimation
    }
    
    private func increaseSizeAnimation(animatedView animatedView: UIView, originalCenter: CGPoint) -> () -> Void {
        
        let increaseSizeAnimation: () -> Void = {
            
            animatedView.alpha = 1
            animatedView.frame.size.width = self.maximumSize
            animatedView.frame.size.height = self.maximumSize
            animatedView.center = originalCenter
            animatedView.alpha = self.minimumAlpha
        }
        
        return increaseSizeAnimation
    }
    
    private func standForAWhileAnimation(
        animatedView animatedView: UIView,
        duration: NSTimeInterval,
        originalView: UIView) -> () -> Void {
            
            let standForAWhileAnimation: () -> Void = {
                
                UIView.animateWithDuration(duration,
                    animations: { () -> Void in
                        animatedView.alpha = 0
                    },
                    completion: { (Bool) -> Void in
                        animatedView.frame.size.width = originalView.frame.size.width
                        animatedView.frame.size.height = originalView.frame.size.height
                        animatedView.center = originalView.center
                })
            }
            
            return standForAWhileAnimation
    }
}