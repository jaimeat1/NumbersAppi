//
//  ConstraintHelper.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 25/02/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation
import UIKit

class ConstraintHelper {
    
    // MARK: Public methods
    
    static func centerInSuperview(subview: UIView) {
        
        if subview.superview != nil {
            centerVerticalyInSuperview(subview)
            centerHorizontalyInSuperview(subview)
        }
    }
    
    static func centerVerticalyInSuperview(subview: UIView) {
        
        if let superview = subview.superview {
            let verticalConstraint = NSLayoutConstraint(
                item: subview,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: superview,
                attribute: NSLayoutAttribute.CenterY,
                multiplier: 1,
                constant: 0)
            
            superview.addConstraint(verticalConstraint)
        }
    }
    
    static func centerHorizontalyInSuperview(subview: UIView) {
        
        if let superview = subview.superview {
            let horizontalConstraint = NSLayoutConstraint(
                item: subview,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: superview,
                attribute: NSLayoutAttribute.CenterX,
                multiplier: 1,
                constant: 0)
            
            superview.addConstraint(horizontalConstraint)
        }
    }
    
    static func sameSizeThanSuperview(subview: UIView) {
        
        if subview.superview != nil {
            sameWidthThanSuperview(subview)
            sameHeightThanSuperview(subview)
        }
    }
    
    static func sameWidthThanSuperview(subview: UIView) {
        
        if let superview = subview.superview {
            
            let widthConstraint = NSLayoutConstraint(
                item: subview,
                attribute: NSLayoutAttribute.Width,
                relatedBy: NSLayoutRelation.Equal,
                toItem: superview,
                attribute: NSLayoutAttribute.Width,
                multiplier: 1,
                constant: 0)
            
            superview.addConstraint(widthConstraint)
        }
    }
    
    static func sameHeightThanSuperview(subview: UIView) {
        
        if let superview = subview.superview {
            
            let heightConstraint = NSLayoutConstraint(
                item: subview,
                attribute: NSLayoutAttribute.Height,
                relatedBy: NSLayoutRelation.Equal,
                toItem: superview,
                attribute: NSLayoutAttribute.Height,
                multiplier: 1,
                constant: 0)
            
            superview.addConstraint(heightConstraint)
        }
    }

}
