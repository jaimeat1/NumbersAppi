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
    
    private var months: [String]!
    
    private let monthPickerNumberOfRows: Int = 12
    private let dayPickerNumberOfRows: Int = 31
    
    private let buttonSize: CGFloat = 30
    private let pickerRowHeight: CGFloat = 50
    private let monthPickerWidth: CGFloat = 150
    private let dayPickerWidth: CGFloat = 60
    private let pickersHorizontalSpace: CGFloat = 20
    private let mainContainerHeight: CGFloat = 130
    
    private var monthContainer: UIView!
    private var monthPicker: UIPickerView!
    private var monthUpButton: UIButton!
    private var monthDownButton: UIButton!
    
    private var dayContainer: UIView!
    private var dayPicker: UIPickerView!
    private var dayUpButton: UIButton!
    private var dayDownButton: UIButton!
    
    private var mainContainer: UIView!
    
    // MARK: Lifecycle objets
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        months = getLocalizedMonths()
        
        setupView()
        
        backgroundColor = UIColor.grayColor()
        
        
        mainContainer = UIView()
        mainContainer.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.backgroundColor = UIColor.blueColor()

        let isMonthFirst = hasRegionalDateMonthAtBeginning()
        let monthXOrigin = isMonthFirst ? 0 : dayPickerWidth + pickersHorizontalSpace
        
        let monthFrame = CGRectMake(monthXOrigin, 0, monthPickerWidth, mainContainerHeight)
        monthPicker = UIPickerView(frame: monthFrame)
        monthPicker.dataSource = self
        monthPicker.delegate = self
        monthPicker.backgroundColor = UIColor.greenColor()
        mainContainer.addSubview(monthPicker)
        
        let dayXOrigin = isMonthFirst ? monthPickerWidth + pickersHorizontalSpace : 0
        let dayFrame = CGRectMake(dayXOrigin, 0, dayPickerWidth, mainContainerHeight)
        dayPicker = UIPickerView(frame: dayFrame)
        dayPicker.dataSource = self
        dayPicker.delegate = self
        dayPicker.backgroundColor = UIColor.redColor()
        mainContainer.addSubview(dayPicker)
        
        addSubview(mainContainer)
    }
    
    override func updateConstraints() {
        
        super.updateConstraints()
        
        let mainContainerWidth = monthPickerWidth + dayPickerWidth + pickersHorizontalSpace
        ConstraintHelper.viewWidth(mainContainer, equalsTo: mainContainerWidth)
        ConstraintHelper.viewHeight(mainContainer, equalsTo: mainContainerHeight)
        ConstraintHelper.centerInSuperview(mainContainer)
        
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
        
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        if (pickerView == monthPicker) {
            return monthPickerNumberOfRows
        } else {
            return dayPickerNumberOfRows
        }
    }
    
    // MARK: UIPickerViewDelegate methods
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        if (pickerView == monthPicker) {
            return months[row]
        } else {
            return String(row)
        }
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return pickerRowHeight
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        
        if (pickerView == monthPicker) {
            return monthPickerWidth
        } else {
            return dayPickerWidth
        }
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
    
    private func getLocalizedMonths() -> [String] {
        
        let months = [
            NSLocalizedString("JANUARY", comment: ""),
            NSLocalizedString("FEBRUARY", comment: ""),
            NSLocalizedString("MARCH", comment: ""),
            NSLocalizedString("APRIL", comment: ""),
            NSLocalizedString("MAY", comment: ""),
            NSLocalizedString("JUNE", comment: ""),
            NSLocalizedString("JULY", comment: ""),
            NSLocalizedString("AUGUST", comment: ""),
            NSLocalizedString("SEPTEMBER", comment: ""),
            NSLocalizedString("OCTOBER", comment: ""),
            NSLocalizedString("NOVEMBER", comment: ""),
            NSLocalizedString("DECEMBER", comment: "")
        ]
        
        return months
    }
}