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
    
    fileprivate var months: [String]!
    fileprivate let buttonSize: CGFloat = 40
    fileprivate let mainContainerHeight: CGFloat = 130
    
    fileprivate let monthPickerNumberOfRows: Int = 12
    fileprivate let dayPickerNumberOfRows: Int = 31
    fileprivate let pickerRowHeight: CGFloat = 50
    fileprivate let monthPickerWidth: CGFloat = 150
    fileprivate let dayPickerWidth: CGFloat = 60
    fileprivate let pickersHorizontalSpace: CGFloat = 20
    
    fileprivate var monthPicker: UIPickerView!
    fileprivate var dayPicker: UIPickerView!

    fileprivate var mainContainer: UIView!
    
    fileprivate let rowFont = UIFont.numbersBoldFontOfSize(24)
    
    // MARK: Lifecycle objets
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        months = getLocalizedMonths()
        backgroundColor = UIColor.clear
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
    
    func setDate(month: Int, day: Int) {
        
        monthPicker.selectRow(month - 1, inComponent: 0, animated: true)
        dayPicker.selectRow(day - 1, inComponent: 0, animated: true)
    }
    
    func getDate() -> (month: Int, day: Int) {
        
        let month = monthPicker.selectedRow(inComponent: 0) + 1
        let day = dayPicker.selectedRow(inComponent: 0) + 1
        
        return (month, day)
    }
    
    // MARK: UIPickerViewDataSource methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        if (pickerView == monthPicker) {
            return monthPickerNumberOfRows
        } else {
            return dayPickerNumberOfRows
        }
    }
    
    // MARK: UIPickerViewDelegate methods
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        if (pickerView == monthPicker) {
            return months[row]
        } else {
            return String(row + 1)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return pickerRowHeight
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        
        if (pickerView == monthPicker) {
            return monthPickerWidth
        } else {
            return dayPickerWidth
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var labelView = view as! UILabel!
        
        if labelView == nil {
            
            let width = (pickerView == monthPicker) ? monthPickerWidth : dayPickerWidth
            labelView = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: pickerRowHeight))
            labelView?.backgroundColor = UIColor.clear
            
            labelView?.textColor = UIColor.white
            labelView?.font = rowFont
            labelView?.textAlignment = NSTextAlignment.center
        }
        
        labelView?.text = (pickerView == monthPicker) ? months[row] : String(row + 1)
        
        return labelView!
    }
    
    // MARK: Action methods
    
    func didSelectMonthUp() {
        
        let newMonth = monthPicker.selectedRow(inComponent: 0) + 1
        monthPicker.selectRow(newMonth, inComponent: 0, animated: true)
    }
    
    func didSelectMonthDown() {
        
        let newMonth = monthPicker.selectedRow(inComponent: 0) - 1
        monthPicker.selectRow(newMonth, inComponent: 0, animated: true)
    }
    
    func didSelectDayUp() {
     
        let newDay = dayPicker.selectedRow(inComponent: 0) + 1
        dayPicker.selectRow(newDay, inComponent: 0, animated: true)
    }
    
    func didSelectDayDown() {
        
        let newDay = dayPicker.selectedRow(inComponent: 0) - 1
        dayPicker.selectRow(newDay, inComponent: 0, animated: true)
    }
    
    // MARK: Private methods

    fileprivate func setupView() {
        
        setupAndAddMainView()
        setupAndAddPickers()
        //setupAndAddButtons()
    }
    
    fileprivate func setupAndAddMainView() {
        
        mainContainer = UIView()
        mainContainer.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.backgroundColor = UIColor.clear
        
        addSubview(mainContainer)
    }
    
    fileprivate func setupAndAddPickers() {
        
        let isMonthFirst = hasRegionalDateMonthAtBeginning()
        let monthXOrigin = isMonthFirst ? 0 : dayPickerWidth + pickersHorizontalSpace
        
        let monthFrame = CGRect(x: monthXOrigin, y: 0, width: monthPickerWidth, height: mainContainerHeight)
        monthPicker = UIPickerView(frame: monthFrame)
        monthPicker.dataSource = self
        monthPicker.delegate = self
        monthPicker.backgroundColor = UIColor.clear
        mainContainer.addSubview(monthPicker)
        
        let dayXOrigin = isMonthFirst ? monthPickerWidth + pickersHorizontalSpace : 0
        let dayFrame = CGRect(x: dayXOrigin, y: 0, width: dayPickerWidth, height: mainContainerHeight)
        dayPicker = UIPickerView(frame: dayFrame)
        dayPicker.dataSource = self
        dayPicker.delegate = self
        dayPicker.backgroundColor = UIColor.clear
        mainContainer.addSubview(dayPicker)
    }
    
    fileprivate func setupAndAddButtons() {
     
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
    
    fileprivate func setupAndAddTypeOfButton(isUp: Bool, withFrame frame: CGRect, action: String) {
     
        let opaqueBackground = UIView(frame: frame)
        opaqueBackground.backgroundColor = UIColor.clear
        let buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        let button = UIButton(frame: buttonFrame)
        let image = isUp ? "arrow_up" : "arrow_down"
        button.setImage(UIImage(named: image), for: UIControlState())
        
        mainContainer.addSubview(opaqueBackground)
        mainContainer.addSubview(button)
        button.center = opaqueBackground.center
        
        button.addTarget(self, action: Selector(action), for: UIControlEvents.touchUpInside)
    }
    
    fileprivate func hasRegionalDateMonthAtBeginning() -> Bool {
        
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.short
        let oneMonth: TimeInterval = 60 * 60 * 24 * 30
        let January31of1970 = Date(timeIntervalSince1970:oneMonth)
        let description = formatter.string(from: January31of1970)

        let dateComponents = description.components(separatedBy: "/")
        let January = 1
        
        return (Int(dateComponents[0]) == January)
    }
    
    fileprivate func getLocalizedMonths() -> [String] {
        
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
