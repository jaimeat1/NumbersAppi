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
    
    private let pickerNumberOfComponents: Int = 5
    private let pickerNumberOfRows: Int = 10
    private let pickerComponentWidth: CGFloat = 40.0
    private let pickerComponentExtraWidth: CGFloat = 5.0
    private let pickerRowHeigth: CGFloat = 50.0
    private let rowFont = UIFont.numbersBoldFontOfSize(26)
    
    private var pickerView: UIPickerView!
    
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
        
        for component in (0 ..< pickerNumberOfComponents).reverse() {
  
            let numberInComponent = pickerView.selectedRowInComponent(component)
            let decimalPow = Int((pow(Double(10), Double(maximumIndex - component))))
            selectedNumber += numberInComponent * decimalPow
        }
        
        return selectedNumber
    }
    
    func setSelectedNumber(var number: Int, animated: Bool) {

        for component in 0 ..< pickerNumberOfComponents {

            let decimalPow = Int((pow(Double(10), Double((pickerNumberOfComponents - 1) - component))))
            let numberInComponent = number / decimalPow
            number -= numberInComponent * decimalPow

            pickerView.selectRow(numberInComponent, inComponent: component, animated: animated)
        }
    }

    // MARK: UIPickerViewDelegate methods
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return String(row)
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return pickerRowHeigth
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        
        return pickerComponentWidth
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        
        var labelView = view as! UILabel!
        
        if labelView == nil {
            
            let width = pickerComponentWidth + pickerComponentExtraWidth
            labelView = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: pickerRowHeigth))
            labelView.backgroundColor = UIColor.numbersBlueLight()
            
            labelView.textColor = UIColor.whiteColor()
            labelView.font = rowFont
            labelView.textAlignment = NSTextAlignment.Center
        }
        
        labelView.text = String(row)
        
        return labelView
    }
    
    // MARK: UIPickerViewDataSource methods
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return pickerNumberOfComponents;
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerNumberOfRows;
    }
    
    // MARK: Private methods
    
    private func setupAndAddPickerView() {
        
        pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.userInteractionEnabled = true
        pickerView.backgroundColor = UIColor.numbersBlueLight()
        
        addSubview(pickerView)
    }
    
    private func updatePickerConstraints() {
        
        ConstraintHelper.centerInSuperview(pickerView)
        ConstraintHelper.sameSizeThanSuperview(pickerView)
    }
    
}
