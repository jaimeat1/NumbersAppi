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
    
    fileprivate let fontSize: CGFloat = 20
    
    fileprivate var textResult: UILabel
    fileprivate var shadowView: UIView
    fileprivate var singleTapView: UIView
    fileprivate var singleTapInfo: UILabel
    fileprivate var singleTapImage: UIImageView
    fileprivate var doubleTapView: UIView
    fileprivate var doubleTapInfo: UILabel
    fileprivate var doubleTapImage: UIImageView
    
    fileprivate var timer: Timer?
    
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
        
        self.shadowView.isHidden = true
        self.singleTapView.isHidden = true
        self.singleTapInfo.isHidden = true
        self.singleTapImage.isHidden = true
        self.doubleTapView.isHidden = true
        self.doubleTapInfo.isHidden = true
        self.doubleTapView.isHidden = true
    }
    
    mutating func showSingleTapWalkthrough() {
        
        self.shadowView.isHidden = false
        
        self.singleTapView.isHidden = false
        self.singleTapInfo.isHidden = false
        self.singleTapImage.isHidden = false
        
        startSingleTapAnimation()
    }
    
    mutating func showDoubleTapWalkthrough() {
        
        self.singleTapView.isHidden = true
        self.singleTapInfo.isHidden = true
        self.singleTapImage.isHidden = true
        
        self.doubleTapView.isHidden = false
        self.doubleTapInfo.isHidden = false
        self.doubleTapView.isHidden = false
        
        timer?.invalidate()
        startDoubleTapAnimation()
    }
    
    func getSingleTapViews() -> [UIView] {
        
        return [textResult, shadowView, singleTapView, singleTapInfo, singleTapImage]
    }
    
    func getDoubleTapViews() -> [UIView] {
    
        return [textResult, shadowView, doubleTapView, doubleTapInfo, doubleTapImage]
    }
    
    func setSingleInfoText(_ text: String) {

        singleTapInfo.text = text
    }
    
    func setDoubleInfoText(_ text: String) {
        
        doubleTapInfo.text = text
    }
    
    // MARK: Private methods
    
    mutating fileprivate func startSingleTapAnimation() {

        let singleBeatAnimation = beatAnimation(
            originalImage: singleTapImage,
            changeDuration: 0.3,
            standDuration: 0.3)
 
        timer = Timer.scheduledTimer(withTimeInterval: 1.0,
            block: { () -> Void in
                singleBeatAnimation()
            }, repeats: true) as? Timer
    }
    
    mutating fileprivate func startDoubleTapAnimation() {

        let firstBeatAnimation = beatAnimation(
            originalImage: doubleTapImage,
            changeDuration: 0.2,
            standDuration: 0.2)
        
        let secondBeatAnimation = beatAnimation(
            originalImage: doubleTapImage,
            changeDuration: 0.2,
            standDuration: 0.2)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0,
            block: { () -> Void in
                
                Timer.scheduledTimer(withTimeInterval: 0,
                    block: { () -> Void in
                        firstBeatAnimation()
                    }, repeats: false) as? Timer
                
                Timer.scheduledTimer(withTimeInterval: 0.3,
                    block: { () -> Void in
                        secondBeatAnimation()
                    }, repeats: false) as? Timer
                
            }, repeats: true) as? Timer
    }
    
    fileprivate func beatAnimation(originalImage: UIImageView, changeDuration: TimeInterval, standDuration: TimeInterval) -> () -> Void  {
        
        let imageToAnimate = UIImageView(frame: originalImage.frame)
        imageToAnimate.image = originalImage.image
        originalImage.superview?.addSubview(imageToAnimate)
        
        let singleIncreaseAnimation = increaseSizeAnimation(animatedView: imageToAnimate, originalCenter: originalImage.center)
        
        let singleStandAnimation = standForAWhileAnimation(
            animatedView: imageToAnimate,
            duration: standDuration,
            originalView: originalImage)
        
        let myBeatAnimation: () -> Void = {
            
            UIView.animate(withDuration: changeDuration,
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
    
    fileprivate func increaseSizeAnimation(animatedView: UIView, originalCenter: CGPoint) -> () -> Void {
        
        let increaseSizeAnimation: () -> Void = {
            
            animatedView.alpha = 1
            animatedView.frame.size.width = self.maximumSize
            animatedView.frame.size.height = self.maximumSize
            animatedView.center = originalCenter
            animatedView.alpha = self.minimumAlpha
        }
        
        return increaseSizeAnimation
    }
    
    fileprivate func standForAWhileAnimation(
        animatedView: UIView,
        duration: TimeInterval,
        originalView: UIView) -> () -> Void {
            
            let standForAWhileAnimation: () -> Void = {
                
                UIView.animate(withDuration: duration,
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
