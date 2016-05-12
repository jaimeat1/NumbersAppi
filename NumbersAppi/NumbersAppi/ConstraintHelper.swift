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
    
    static func viewWidth(view: UIView, equalsTo width: CGFloat) {
        
        let widthConstraint = NSLayoutConstraint(
            item: view,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: width)
        
        view.addConstraint(widthConstraint)
    }
    
    static func viewHeight(view: UIView, equalsTo height: CGFloat) {
        
        let heightConstraint = NSLayoutConstraint(
            item: view,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: height)
        
        view.addConstraint(heightConstraint)
    }
    
    static func topSpaceToContainer(subview: UIView, equalTo topSpace: CGFloat) {
        
        if let superview = subview.superview {
            
            let topSpaceConstraint = NSLayoutConstraint(
                item: subview,
                attribute: NSLayoutAttribute.Top,
                relatedBy: NSLayoutRelation.Equal,
                toItem: superview,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: topSpace)
            
            superview.addConstraint(topSpaceConstraint)
        }
    }
    
    static func bottomSpaceToContainer(subview: UIView, equalTo bottomSpace: CGFloat) {
        
        if let superview = subview.superview {
            
            let bottomSpaceConstraint = NSLayoutConstraint(
                item: subview,
                attribute: NSLayoutAttribute.Bottom,
                relatedBy: NSLayoutRelation.Equal,
                toItem: superview,
                attribute: NSLayoutAttribute.Bottom,
                multiplier: 1.0,
                constant: bottomSpace)
            
            superview.addConstraint(bottomSpaceConstraint)
        }
    }
    
    static func horizontalSpaceToParent(subview: UIView, equalTo horizontalSpace: CGFloat) {
        
        if let superview = subview.superview {
            
            let horizantalConstraint = NSLayoutConstraint(
                item: subview,
                attribute: NSLayoutAttribute.Left,
                relatedBy: NSLayoutRelation.Equal,
                toItem: superview,
                attribute: NSLayoutAttribute.Left,
                multiplier: 1.0,
                constant: horizontalSpace)
            
            superview.addConstraint(horizantalConstraint)
        }
    }
    
     static func equalWidthInView(view1: UIView, thanInView view2: UIView) {
        
        // TODO: check if both views are in the same hierarchy tree, not only brothers
        
        if let parentView = view1.superview {
            
            if parentView == view2.superview {
                
                let widthConstraint = NSLayoutConstraint(
                    item: view1,
                    attribute: NSLayoutAttribute.Width,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: view2,
                    attribute: NSLayoutAttribute.Width,
                    multiplier: 1.0,
                    constant: 0)
                
                parentView.addConstraint(widthConstraint)
            }
        }
    }
    
    static func equalLeadingForViews(view1: UIView, view2: UIView) {
        
        if let parentView = view1.superview {
            
            if parentView == view2.superview {
                
                let alignLeft = NSLayoutConstraint(
                    item: view1,
                    attribute: NSLayoutAttribute.Leading,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: view2,
                    attribute: NSLayoutAttribute.Leading,
                    multiplier: 1.0,
                    constant: 0.0)
                
                parentView.addConstraint(alignLeft)
            }
        }
    }
    
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
