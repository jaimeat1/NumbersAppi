//
//  DatePickerView.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 08/03/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation
import UIKit

class DatePickerView: UIView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var monthContainer: UIView!
    var monthPicker: UIPickerView!
    var monthUpButton: UIButton!
    var monthDownButton: UIButton!
    
    var dayContainer: UIView!
    var dayPicker: UIPickerView!
    var dayUpButton: UIButton!
    var dayDownButton: UIButton!
    
    // MARK: Lifecycle objets
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    override func updateConstraints() {
        
        super.updateConstraints()
        
        // TODO: update constraints
    }
    
    // MARK: Public methods
    
    func setDate() {
        
        // TODO: set given date in pickers view
    }
    
    func getDate() {
        
        // TODO: get current date in pickers view
    }
    
    // MARK: UIPickerViewDataSource methods
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        // TODO: return number of components
        return 0;
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        // TODO: return number of original values
        return 0;
    }
    
    // MARK: UIPickerViewDelegate methods
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        // TODO: return days or months
        return ""
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        // TODO: return componnent height
        return 0
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        
        // TODO: return componnent width
        return 0
    }
    
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
    
    private func setupView() {
        
        // TODO: setup containers, pickers, buttons
    }
}