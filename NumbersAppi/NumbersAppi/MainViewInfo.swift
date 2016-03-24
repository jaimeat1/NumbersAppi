//
//  MainViewInfo.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 24/03/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation
import UIKit

protocol MainViewInfoDelegate {
    
    func didHideInfoView()
}

struct MainViewInfoViews {
    
    var textResult: UILabel
    
    var shadowView: UIView

    var singleTapView: UIView
    var singleTapInfo: UILabel
    var singleTapImage: UIImageView
    var doubleTapView: UIView
    var doubleTapInfo: UILabel
    var doubleTapImage: UIImageView
    
    func hide() {
        
        self.shadowView.hidden = true
        self.singleTapView.hidden = true
        self.singleTapInfo.hidden = true
        self.singleTapImage.hidden = true
        self.doubleTapView.hidden = true
        self.doubleTapInfo.hidden = true
        self.doubleTapView.hidden = true
    }
    
    func showSingle() {
        
        self.shadowView.hidden = false
        
        self.singleTapView.hidden = false
        self.singleTapInfo.hidden = false
        self.singleTapImage.hidden = false
    }
    
    func showDouble() {
        
        self.singleTapView.hidden = true
        self.singleTapInfo.hidden = true
        self.singleTapImage.hidden = true
        
        self.doubleTapView.hidden = false
        self.doubleTapInfo.hidden = false
        self.doubleTapView.hidden = false
    }
}

class MainViewInfo {
    
    private var delegate: MainViewInfoDelegate!
    private var infoViews: MainViewInfoViews
    private var singleViews: [UIView]!
    private var doubleViews: [UIView]!
 
    // MARK: Lifecycle methods
    
    init(infoViews: MainViewInfoViews, delegate: MainViewInfoDelegate) {
        
        self.infoViews = infoViews
        self.delegate = delegate
        
        singleViews = [
            infoViews.textResult,
            infoViews.shadowView,
            infoViews.singleTapView,
            infoViews.singleTapInfo,
            infoViews.singleTapImage]
        
        doubleViews = [
            infoViews.textResult,
            infoViews.shadowView,
            infoViews.doubleTapView,
            infoViews.doubleTapInfo,
            infoViews.doubleTapImage]
        
        localizeTexts()
    }
    
    // MARK: Public methods
    
    func show() {
        
        infoViews.hide()
        infoViews.showSingle()
        addTapGestureForSingleView()
    }
    
    // MARK: Action methods
    
    @IBAction func didTapWithSingleViewShowing() {
        
        infoViews.showDouble()
        removeTapGestureForSingleView()
        addTapGestureForDoubleView()
    }
    
    @IBAction func didTapWithDoubleViewShowing() {
        
        infoViews.hide()
        removeTapGestureForDoubleView()
        delegate.didHideInfoView()
    }
    
    // MARK: Private methods
    
    private func localizeTexts() {
        
        infoViews.singleTapInfo.text = NSLocalizedString("SINGLE_TAP", comment: "Description for single tap")
        infoViews.doubleTapInfo.text = NSLocalizedString("DOUBLE_TAP", comment: "Description for double tap")
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