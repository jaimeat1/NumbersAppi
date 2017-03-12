//
//  NumberPickerView.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 23/02/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Darwin
import Foundation
import UIKit

// TODO: publish it as library: as circular picker view? as picker view with selectors?
class NumberPickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    fileprivate let pickerNumberOfComponents: Int = 5
    fileprivate let pickerNumberOfRows: Int = 10
    fileprivate let pickerComponentWidth: CGFloat = 40.0
    fileprivate let pickerComponentExtraWidth: CGFloat = 5.0
    fileprivate let pickerRowHeigth: CGFloat = 50.0
    fileprivate let rowFont = UIFont.numbersBoldFontOfSize(26)
    
    fileprivate var pickerView: UIPickerView!
    
    // MARK: Lifecycle objets

    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        setupAndAddPickerView()
    }
    
    override func updateConstraints() {
        
        super.updateConstraints()
        
        updatePickerConstraints()
    }

    // MARK: public methods
    
    func getSelectedNumber() -> Int {
        
        var selectedNumber: Int = 0
        let maximumIndex = pickerNumberOfComponents - 1
        
        for component in (0 ..< pickerNumberOfComponents).reversed() {
  
            let numberInComponent = pickerView.selectedRow(inComponent: component)
            let decimalPow = Int((pow(Double(10), Double(maximumIndex - component))))
            selectedNumber += numberInComponent * decimalPow
        }
        
        return selectedNumber
    }
    
    func setSelectedNumber(_ number: Int, animated: Bool) {

        var newNumber = number
        for component in 0 ..< pickerNumberOfComponents {

            let decimalPow = Int((pow(Double(10), Double((pickerNumberOfComponents - 1) - component))))
            let numberInComponent = newNumber / decimalPow
            newNumber = newNumber - (numberInComponent * decimalPow)

            pickerView.selectRow(numberInComponent, inComponent: component, animated: animated)
        }
    }

    // MARK: UIPickerViewDelegate methods
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return String(row)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return pickerRowHeigth
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        
        return pickerComponentWidth
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var labelView = view as! UILabel!
        
        if labelView == nil {
            
            let width = pickerComponentWidth + pickerComponentExtraWidth
            labelView = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: pickerRowHeigth))
            labelView?.backgroundColor = UIColor.clear
            
            labelView?.textColor = UIColor.white
            labelView?.font = rowFont
            labelView?.textAlignment = NSTextAlignment.center
        }
        
        labelView?.text = String(row)
        
        return labelView!
    }
    
    // MARK: UIPickerViewDataSource methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return pickerNumberOfComponents;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerNumberOfRows;
    }
    
    // MARK: Private methods
    
    fileprivate func setupAndAddPickerView() {
        
        pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.isUserInteractionEnabled = true
        pickerView.backgroundColor = UIColor.clear
        
        addSubview(pickerView)
    }
    
    fileprivate func updatePickerConstraints() {
        
        ConstraintHelper.centerInSuperview(pickerView)
        ConstraintHelper.sameSizeThanSuperview(pickerView)
    }
    
}
