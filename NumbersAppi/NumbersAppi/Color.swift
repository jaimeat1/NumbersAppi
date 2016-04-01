//
//  Color.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 01/04/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    var numbersBlue : String { get { return "" } }
    var numbersDarkBlue : String { get { return "" } }
    var numbersMediumBlue : String { get { return "" } }
    
    // MARK: Private methods
    
    private func colorWith8Bit(red red: Int, green: Int, blue: Int, alpha: Float) -> UIColor {
        
        return UIColor(
            red: CGFloat(red/255),
            green: CGFloat(green/250),
            blue: CGFloat(blue/250),
            alpha: CGFloat(alpha))
    }

    private func colorWithHex(hex: String, andAlpha alpha: Float) -> UIColor {
        
        assert(7 == hex.characters.count)
        assert("#" == hex.characters.first)
        
        let redHex = "0x" + hex.substringWithRange((Range<String.Index>(start: hex.startIndex.advancedBy(1), end: hex.endIndex.advancedBy(2))))
        let greenHex = "0x" + hex.substringWithRange((Range<String.Index>(start: hex.startIndex.advancedBy(3), end: hex.endIndex.advancedBy(4))))
        let blueHex = "0x" + hex.substringWithRange((Range<String.Index>(start: hex.startIndex.advancedBy(5), end: hex.endIndex.advancedBy(6))))
        
        let redPointer = UnsafeMutablePointer<Int32>.alloc(0)
        let redScanner = NSScanner(string: redHex)
        redScanner.scanInt(redPointer)
        
        let greenPointer = UnsafeMutablePointer<Int32>.alloc(0)
        let greenScanner = NSScanner(string: greenHex)
        greenScanner.scanInt(greenPointer)
        
        let bluePointer = UnsafeMutablePointer<Int32>.alloc(0)
        let blueScanner = NSScanner(string: blueHex)
        blueScanner.scanInt(bluePointer)
        
        let redInt: Int32 = UnsafePointer<Int32>(redPointer).memory
        let greenInt: Int32 = UnsafePointer<Int32>(greenPointer).memory
        let blueInt: Int32 = UnsafePointer<Int32>(bluePointer).memory
        
        return colorWith8Bit(red: Int(redInt), green: Int(greenInt), blue: Int(blueInt), alpha: alpha)
    }
}