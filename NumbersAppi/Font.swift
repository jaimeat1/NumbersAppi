//
//  Font.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 05/04/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    fileprivate static var numbersTitleFontNormal: String { get {return "Calibri"} }
    fileprivate static var numbersTitleFontBold: String { get {return "Calibri-Bold"} }
    fileprivate static var numbersResponseFont: String { get {return "ChaparralPro-Regular"} }

    // MARK: Public methods
    
    static func numbersNormalFontOfSize(_ size: CGFloat) -> UIFont {
        
        return getSystemFontOrFontWithName(numbersTitleFontNormal, andSize: size)
    }
    
    static func numbersBoldFontOfSize(_ size: CGFloat) -> UIFont {
        
        return getSystemFontOrFontWithName(numbersTitleFontBold, andSize: size)
    }
    
    static func numbersResponseFontOfSize(_ size: CGFloat) -> UIFont {
        
        return getSystemFontOrFontWithName(numbersResponseFont, andSize: size)
    }
    
    // MARK: Private methods
    
    fileprivate static func getSystemFontOrFontWithName(_ name: String, andSize size: CGFloat) -> UIFont {

        if let font = UIFont.init(name: name, size: size) {
            return font
        } else {
            NSLog("didn't find font named \(name)")
            return UIFont.systemFont(ofSize: size)
        }
    }
    
}
