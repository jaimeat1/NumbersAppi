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
    private let pickerComponentExtraWidth: CGFloat = 5.0
    private let pickerRowHeigth: CGFloat = 50.0

    private let containerHeight: CGFloat = 40.0
    private let buttonSize: CGFloat = 30.0
    
    private var pickerView: UIPickerView!
    private var upperContainer: UIView!
    private var bottomContainer: UIView!
    
    // MARK: Lifecycle objets

    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        

        setupAndAddPickerView()
        setupAndAddSelectorViews()
        
        backgroundColor = UIColor.grayColor()
        pickerView.backgroundColor = UIColor.lightGrayColor()
    }
    
    func setHeight(height: CGFloat, inView: UIView) {
        
    }
    
    override func updateConstraints() {
        
        super.updateConstraints()

        ConstraintHelper.centerInSuperview(pickerView)
        ConstraintHelper.sameSizeThanSuperview(pickerView)
        
        // TODO: set container view height to selectorSize
        
        let heightConstraint = NSLayoutConstraint(
            item: upperContainer,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: containerHeight)
        
        upperContainer.addConstraint(heightConstraint)
        
        // TODO: set container view width to picker view
        
        let widthConstraint = NSLayoutConstraint(
            item: upperContainer,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: pickerView,
            attribute: NSLayoutAttribute.Width,
            multiplier: 1.0,
            constant: 0)
        
        addConstraint(widthConstraint)
        
        // TODO: align container view left side to picker view left side
        
        let alignLeft = NSLayoutConstraint(
            item: upperContainer,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: pickerView,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1.0,
            constant: 0.0)
        
        addConstraint(alignLeft)
        
        // TODO: set container view vertical space to picker view to zero
        
        let verticalSpace = NSLayoutConstraint(
            item: upperContainer,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 0.0)
        
        addConstraint(verticalSpace)
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
    
    // MARK: Private methods
    
    private func setupAndAddPickerView() {
        
        pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.delegate = self
        pickerView.dataSource = self
        addSubview(pickerView)
    }
    
    private func setupAndAddSelectorViews() {

        // TODO: build container view
        
        let frame = CGRectMake(0, 0, 0, 0)
        upperContainer = UIView(frame: frame)
        upperContainer.translatesAutoresizingMaskIntoConstraints = false
        upperContainer.backgroundColor = UIColor.yellowColor()
 
        let image: UIImage = UIImage(imageLiteral: "arrow_up")
        
        for i in 1 ... pickerNumberOfComponents {
            
            let button = UIButton(frame: CGRectMake(0, 0, buttonSize, buttonSize))
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(image, forState: UIControlState.Normal)
            upperContainer.addSubview(button)
            
            ConstraintHelper.centerVerticalyInSuperview(button)

            let realPickerWidth = pickerComponentWidth + pickerComponentExtraWidth
            let multiplier = CGFloat(i)
            let availableSpace = pickerComponentWidth - buttonSize
            
            if i == 1 {
                
                let horizontalSpace = NSLayoutConstraint(
                    item: button,
                    attribute: NSLayoutAttribute.Left,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: upperContainer,
                    attribute: NSLayoutAttribute.Left,
                    multiplier: 1.0,
                    constant: realPickerWidth + availableSpace)
                
                addConstraint(horizontalSpace)
                
            } else {
                
                let horizontalSpace = NSLayoutConstraint(
                    item: button,
                    attribute: NSLayoutAttribute.Left,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: upperContainer,
                    attribute: NSLayoutAttribute.Left,
                    multiplier: 1.0,
                    constant: (realPickerWidth * multiplier) + availableSpace)
                
                addConstraint(horizontalSpace)
            }

        }
        
        addSubview(upperContainer)
    }

}
