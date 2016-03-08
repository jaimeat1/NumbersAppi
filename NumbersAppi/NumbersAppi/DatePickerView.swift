//
//  DatePickerView.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 08/03/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation
import UIKit

class DatePickerView: UIView {
    
    // MARK: Private methods
    
    private func hasRegionalDateMonthAtBeginning() -> Bool {
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        let oneMonth: NSTimeInterval = 60 * 60 * 24 * 30
        let January31of1970 = NSDate(timeIntervalSince1970:oneMonth)
        let description = formatter.stringFromDate(January31of1970)

        let dateComponents = description.componentsSeparatedByString("/")
        let January = 1
        
        return (Int(dateComponents[0]) == January)
    }
}