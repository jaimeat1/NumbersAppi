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
    
    private static var numbersTitleFontNormal: String { get {return "Calibri"} }
    private static var numbersTitleFontBold: String { get {return "Calibri-Bold"} }
    private static var numbersResponseFont: String { get {return "ChaparralPro-Regular"} }

    // MARK: Public methods
    
    static func numbersTitleFontNormalOfSize(size: CGFloat) -> UIFont {
        
        return getSystemFontOrFontWithName(numbersTitleFontNormal, andSize: size)
    }
    
    static func numbersTitleFontBoldOfSize(size: CGFloat) -> UIFont {
        
        return getSystemFontOrFontWithName(numbersTitleFontBold, andSize: size)
    }
    
    static func numbersResponseFontOfSize(size: CGFloat) -> UIFont {
        
        return getSystemFontOrFontWithName(numbersResponseFont, andSize: size)
    }
    
    // MARK: Private methods
    
    private static func getSystemFontOrFontWithName(name: String, andSize size: CGFloat) -> UIFont {
        
        for family: String in UIFont.familyNames()
        {
            print("\(family)")
            for names: String in UIFont.fontNamesForFamilyName(family)
            {
                print("== \(names)")
            }
        }

        if let font = UIFont.init(name: name, size: size) {
            return font
        } else {
            NSLog("didn't find font named \(name)")
            return UIFont.systemFontOfSize(size)
        }
    }
    
}