//
//  ConstraintHelper.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 25/02/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation
import UIKit

// TODO: publish it as library
// TODO: add error messages if constraint can't be applied
class ConstraintHelper {
    
    // MARK: Public methods
    
    static func viewWidth(_ view: UIView, equalsTo width: CGFloat) {
        
        let widthConstraint = NSLayoutConstraint(
            item: view,
            attribute: NSLayoutAttribute.width,
            relatedBy: NSLayoutRelation.equal,
            toItem: nil,
            attribute: NSLayoutAttribute.notAnAttribute,
            multiplier: 1.0,
            constant: width)
        
        view.addConstraint(widthConstraint)
    }
    
    static func viewHeight(_ view: UIView, equalsTo height: CGFloat) {
        
        let heightConstraint = NSLayoutConstraint(
            item: view,
            attribute: NSLayoutAttribute.height,
            relatedBy: NSLayoutRelation.equal,
            toItem: nil,
            attribute: NSLayoutAttribute.notAnAttribute,
            multiplier: 1.0,
            constant: height)
        
        view.addConstraint(heightConstraint)
    }
    
    static func topSpaceToContainer(_ subview: UIView, equalTo topSpace: CGFloat) {
        
        if let superview = subview.superview {
            
            let topSpaceConstraint = NSLayoutConstraint(
                item: subview,
                attribute: NSLayoutAttribute.top,
                relatedBy: NSLayoutRelation.equal,
                toItem: superview,
                attribute: NSLayoutAttribute.top,
                multiplier: 1.0,
                constant: topSpace)
            
            superview.addConstraint(topSpaceConstraint)
        }
    }
    
    static func bottomSpaceToContainer(_ subview: UIView, equalTo bottomSpace: CGFloat) {
        
        if let superview = subview.superview {
            
            let bottomSpaceConstraint = NSLayoutConstraint(
                item: subview,
                attribute: NSLayoutAttribute.bottom,
                relatedBy: NSLayoutRelation.equal,
                toItem: superview,
                attribute: NSLayoutAttribute.bottom,
                multiplier: 1.0,
                constant: bottomSpace)
            
            superview.addConstraint(bottomSpaceConstraint)
        }
    }
    
    static func horizontalSpaceToParent(_ subview: UIView, equalTo horizontalSpace: CGFloat) {
        
        if let superview = subview.superview {
            
            let horizantalConstraint = NSLayoutConstraint(
                item: subview,
                attribute: NSLayoutAttribute.left,
                relatedBy: NSLayoutRelation.equal,
                toItem: superview,
                attribute: NSLayoutAttribute.left,
                multiplier: 1.0,
                constant: horizontalSpace)
            
            superview.addConstraint(horizantalConstraint)
        }
    }
    
     static func equalWidthInView(_ view1: UIView, thanInView view2: UIView) {
        
        // TODO: check if both views are in the same hierarchy tree, not only brothers
        
        if let parentView = view1.superview {
            
            if parentView == view2.superview {
                
                let widthConstraint = NSLayoutConstraint(
                    item: view1,
                    attribute: NSLayoutAttribute.width,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: view2,
                    attribute: NSLayoutAttribute.width,
                    multiplier: 1.0,
                    constant: 0)
                
                parentView.addConstraint(widthConstraint)
            }
        }
    }
    
    static func equalLeadingForViews(_ view1: UIView, view2: UIView) {
        
        if let parentView = view1.superview {
            
            if parentView == view2.superview {
                
                let alignLeft = NSLayoutConstraint(
                    item: view1,
                    attribute: NSLayoutAttribute.leading,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: view2,
                    attribute: NSLayoutAttribute.leading,
                    multiplier: 1.0,
                    constant: 0.0)
                
                parentView.addConstraint(alignLeft)
            }
        }
    }
    
    static func centerInSuperview(_ subview: UIView) {
        
        if subview.superview != nil {
            centerVerticalyInSuperview(subview)
            centerHorizontalyInSuperview(subview)
        }
    }
    
    static func centerVerticalyInSuperview(_ subview: UIView) {
        
        if let superview = subview.superview {
            let verticalConstraint = NSLayoutConstraint(
                item: subview,
                attribute: NSLayoutAttribute.centerY,
                relatedBy: NSLayoutRelation.equal,
                toItem: superview,
                attribute: NSLayoutAttribute.centerY,
                multiplier: 1,
                constant: 0)
            
            superview.addConstraint(verticalConstraint)
        }
    }
    
    static func centerHorizontalyInSuperview(_ subview: UIView) {
        
        if let superview = subview.superview {
            let horizontalConstraint = NSLayoutConstraint(
                item: subview,
                attribute: NSLayoutAttribute.centerX,
                relatedBy: NSLayoutRelation.equal,
                toItem: superview,
                attribute: NSLayoutAttribute.centerX,
                multiplier: 1,
                constant: 0)
            
            superview.addConstraint(horizontalConstraint)
        }
    }
    
    static func sameSizeThanSuperview(_ subview: UIView) {
        
        if subview.superview != nil {
            sameWidthThanSuperview(subview)
            sameHeightThanSuperview(subview)
        }
    }
    
    static func sameWidthThanSuperview(_ subview: UIView) {
        
        if let superview = subview.superview {
            
            let widthConstraint = NSLayoutConstraint(
                item: subview,
                attribute: NSLayoutAttribute.width,
                relatedBy: NSLayoutRelation.equal,
                toItem: superview,
                attribute: NSLayoutAttribute.width,
                multiplier: 1,
                constant: 0)
            
            superview.addConstraint(widthConstraint)
        }
    }
    
    static func sameHeightThanSuperview(_ subview: UIView) {
        
        if let superview = subview.superview {
            
            let heightConstraint = NSLayoutConstraint(
                item: subview,
                attribute: NSLayoutAttribute.height,
                relatedBy: NSLayoutRelation.equal,
                toItem: superview,
                attribute: NSLayoutAttribute.height,
                multiplier: 1,
                constant: 0)
            
            superview.addConstraint(heightConstraint)
        }
    }

}
