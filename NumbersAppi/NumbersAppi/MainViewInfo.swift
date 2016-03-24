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
    
    var textResult: UILabel!
    
    var shadowView: UIView!
    
    var singleTapView: UIView!
    var singleTapInfo: UILabel!
    var singleTapImage: UIImageView!
    var doubleTapView: UIView!
    var doubleTapInfo: UILabel!
    var doubleTapImage: UIImageView!
    
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
        
        self.doubleTapView.hidden = false
        self.doubleTapInfo.hidden = false
        self.doubleTapView.hidden = false
    }
}

class MainViewInfo {
    
    var delegate: MainViewInfoDelegate!
    
    private var infoViews: MainViewInfoViews
    private var singleTapGesture: UITapGestureRecognizer!
    private var doubleTapGesture: UITapGestureRecognizer!
 
    // MARK: Lifecycle methods
    
    init(infoViews: MainViewInfoViews, delegate: MainViewInfoDelegate) {
        
        self.infoViews = infoViews
        self.delegate = delegate
        
        localizeTexts()
    }
    
    // MARK: Public methods
    
    func show() {
        
        infoViews.showSingle()
        addTapGestureForSingleView()
    }
    
    // MARK: Action methods
    
    @IBAction func didTapWithSingleViewShowing() {
        
        infoViews.showDouble()
        removeGestureToAllViews(singleTapGesture)
        addTapGestureForDoubleView()
    }
    
    @IBAction func didTapWithDoubleViewShowing() {
        
        infoViews.hide()
        removeGestureToAllViews(doubleTapGesture)
        delegate.didHideInfoView()
    }
    
    // MARK: Private methods
    
    private func localizeTexts() {
        
        infoViews.singleTapInfo.text = NSLocalizedString("SINGLE_TAP", comment: "Description for single tap")
        infoViews.doubleTapInfo.text = NSLocalizedString("DOUBLE_TAP", comment: "Description for double tap")
    }
    
    private func addTapGestureForSingleView() {
        
        singleTapGesture = UITapGestureRecognizer.init(target: self, action: "didTapWithSingleViewShowing")
        addGestureToAllViews(singleTapGesture)
    }
    
    private func addTapGestureForDoubleView() {
        
        doubleTapGesture = UITapGestureRecognizer.init(target: self, action: "didTapWithDoubleViewShowing")
        addGestureToAllViews(doubleTapGesture)
    }
    
    private func addGestureToAllViews(tapGesture: UITapGestureRecognizer) {
        
        infoViews.textResult.addGestureRecognizer(tapGesture)
        infoViews.shadowView.addGestureRecognizer(tapGesture)
        infoViews.singleTapView.addGestureRecognizer(tapGesture)
        infoViews.singleTapInfo.addGestureRecognizer(tapGesture)
        infoViews.singleTapImage.addGestureRecognizer(tapGesture)
    }
    
    private func removeGestureToAllViews(tapGesture: UITapGestureRecognizer) {
        
        infoViews.textResult.removeGestureRecognizer(tapGesture)
        infoViews.shadowView.removeGestureRecognizer(tapGesture)
        infoViews.singleTapView.removeGestureRecognizer(tapGesture)
        infoViews.singleTapInfo.removeGestureRecognizer(tapGesture)
        infoViews.singleTapImage.removeGestureRecognizer(tapGesture)
    }
    
}