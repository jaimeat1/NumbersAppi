//
//  NumberPickerView.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 23/02/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation
import UIKit

class NumberPickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private let pickerNumberOfComponents: Int = 5
    private let pickerComponentWidth: CGFloat = 40.0
    private let pickerRowHeigth: CGFloat = 50.0
    
    private var pickerView: UIPickerView!
    
    // MARK: Lifecicly objets

    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.delegate = self
        pickerView.dataSource = self
        addSubview(pickerView)
    }
    
    override func updateConstraints() {
        
        super.updateConstraints()

        ConstraintHelper.centerInSuperview(pickerView)
        ConstraintHelper.sameSizeThanSuperview(pickerView)
    }

    // MARK: public methods
    
    func getSelectedNumber() -> Int {
        
        // TODO: get number from picker
        return 0
    }
    
    func setSelectedNumber(number: Int, animated: Bool) {
        
        // TODO: set number in picker
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
    
    // MARK: UIPickerViewDataSource methods
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return pickerNumberOfComponents;
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return 10;
    }
    
}
