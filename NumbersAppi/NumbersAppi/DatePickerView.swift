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
    private let buttonSize: CGFloat = 30
    private let mainContainerHeight: CGFloat = 130
    
    private let monthPickerNumberOfRows: Int = 12
    private let dayPickerNumberOfRows: Int = 31
    private let pickerRowHeight: CGFloat = 50
    private let monthPickerWidth: CGFloat = 150
    private let dayPickerWidth: CGFloat = 60
    private let pickersHorizontalSpace: CGFloat = 20
    
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
    }
    
    override func updateConstraints() {
        
        super.updateConstraints()
        
        let mainContainerWidth = monthPickerWidth + dayPickerWidth + pickersHorizontalSpace
        ConstraintHelper.viewWidth(mainContainer, equalsTo: mainContainerWidth)
        ConstraintHelper.viewHeight(mainContainer, equalsTo: mainContainerHeight)
        ConstraintHelper.centerInSuperview(mainContainer)
    }
    
    // MARK: Public methods
    
    func setDate(month month: Int, day: Int) {
        
        monthPicker.selectRow(month - 1, inComponent: 0, animated: true)
        dayPicker.selectRow(day - 1, inComponent: 0, animated: true)
    }
    
    func getDate() -> (month: Int, day: Int) {
        
        let month = monthPicker.selectedRowInComponent(0) + 1
        let day = dayPicker.selectedRowInComponent(0) + 1
        
        return (month, day)
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
            return String(row + 1)
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
    
    // MARK: Action methods
    
    func didSelectMonthUp() {
        
        let newMonth = monthPicker.selectedRowInComponent(0) + 1
        monthPicker.selectRow(newMonth, inComponent: 0, animated: true)
    }
    
    func didSelectMonthDown() {
        
        let newMonth = monthPicker.selectedRowInComponent(0) - 1
        monthPicker.selectRow(newMonth, inComponent: 0, animated: true)
    }
    
    func didSelectDayUp() {
     
        let newDay = dayPicker.selectedRowInComponent(0) + 1
        dayPicker.selectRow(newDay, inComponent: 0, animated: true)
    }
    
    func didSelectDayDown() {
        
        let newDay = dayPicker.selectedRowInComponent(0) - 1
        dayPicker.selectRow(newDay, inComponent: 0, animated: true)
    }
    
    // MARK: Private methods

    private func setupView() {
        
        setupAndAddMainView()
        setupAndAddPickers()
        setupAndAddButtons()
    }
    
    private func setupAndAddMainView() {
        
        mainContainer = UIView()
        mainContainer.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(mainContainer)
    }
    
    private func setupAndAddPickers() {
        
        let isMonthFirst = hasRegionalDateMonthAtBeginning()
        let monthXOrigin = isMonthFirst ? 0 : dayPickerWidth + pickersHorizontalSpace
        
        let monthFrame = CGRect(x: monthXOrigin, y: 0, width: monthPickerWidth, height: mainContainerHeight)
        monthPicker = UIPickerView(frame: monthFrame)
        monthPicker.dataSource = self
        monthPicker.delegate = self
        mainContainer.addSubview(monthPicker)
        
        let dayXOrigin = isMonthFirst ? monthPickerWidth + pickersHorizontalSpace : 0
        let dayFrame = CGRect(x: dayXOrigin, y: 0, width: dayPickerWidth, height: mainContainerHeight)
        dayPicker = UIPickerView(frame: dayFrame)
        dayPicker.dataSource = self
        dayPicker.delegate = self
        mainContainer.addSubview(dayPicker)
    }
    
    private func setupAndAddButtons() {
     
        let isMonthFirst = hasRegionalDateMonthAtBeginning()
        let monthXOrigin = isMonthFirst ? 0 : dayPickerWidth + pickersHorizontalSpace
        let opaqueBackgroundHeight = (mainContainerHeight - pickerRowHeight) / 2
        
        var frame = CGRect(x: monthXOrigin, y: 0, width: monthPickerWidth, height: opaqueBackgroundHeight)
        setupAndAddTypeOfButton(isUp: true, withFrame: frame, action: "didSelectMonthUp")
        
        frame = CGRect(
            x: monthXOrigin,
            y: mainContainerHeight - opaqueBackgroundHeight,
            width: monthPickerWidth,
            height: opaqueBackgroundHeight)
        setupAndAddTypeOfButton(isUp: false, withFrame: frame, action: "didSelectMonthDown")
        
        let dayXOrigin = isMonthFirst ? monthPickerWidth + pickersHorizontalSpace : 0

        frame = CGRect(x: dayXOrigin, y: 0, width: dayPickerWidth, height: opaqueBackgroundHeight)
        setupAndAddTypeOfButton(isUp: true, withFrame: frame, action: "didSelectDayUp")
        
        frame = CGRect(
            x: dayXOrigin,
            y: mainContainerHeight - opaqueBackgroundHeight,
            width: dayPickerWidth,
            height: opaqueBackgroundHeight)
        setupAndAddTypeOfButton(isUp: false, withFrame: frame, action: "didSelectDayDown")
    }
    
    private func setupAndAddTypeOfButton(isUp isUp: Bool, withFrame frame: CGRect, action: String) {
     
        let opaqueBackground = UIView(frame: frame)
        opaqueBackground.backgroundColor = UIColor.whiteColor()
        let buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        let button = UIButton(frame: buttonFrame)
        let image = isUp ? "arrow_up" : "arrow_down"
        button.setImage(UIImage(named: image), forState: UIControlState.Normal)
        
        mainContainer.addSubview(opaqueBackground)
        mainContainer.addSubview(button)
        button.center = opaqueBackground.center
        
        button.addTarget(self, action: Selector(action), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
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
    
    private func getLocalizedMonths() -> [String] {
        
        let months = [
            NSLocalizedString("JANUARY", comment: "January month"),
            NSLocalizedString("FEBRUARY", comment: "February month"),
            NSLocalizedString("MARCH", comment: "March month"),
            NSLocalizedString("APRIL", comment: "April month"),
            NSLocalizedString("MAY", comment: "May month"),
            NSLocalizedString("JUNE", comment: "June month"),
            NSLocalizedString("JULY", comment: "July month"),
            NSLocalizedString("AUGUST", comment: "August month"),
            NSLocalizedString("SEPTEMBER", comment: "September month"),
            NSLocalizedString("OCTOBER", comment: "October month"),
            NSLocalizedString("NOVEMBER", comment: "November month"),
            NSLocalizedString("DECEMBER", comment: "December month")
        ]
        
        return months
    }
}