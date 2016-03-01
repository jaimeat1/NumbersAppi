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
    
    private var upperButtons = NSArray()
    private var bottomButtons = NSArray()
    
    // MARK: Lifecycle objets

    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)

        setupAndAddPickerView()
        setupAndAddSelectorViews()
        
        // TODO: delete
        backgroundColor = UIColor.grayColor()
        pickerView.backgroundColor = UIColor.lightGrayColor()
        upperContainer.backgroundColor = UIColor.yellowColor()
        bottomContainer.backgroundColor = UIColor.yellowColor()
    }
    
    override func updateConstraints() {
        
        super.updateConstraints()

        updatePickerConstraints()
        updateUpperContainerConstraints()
        updateBottomContainerConstraints()
    }

    // MARK: public methods
    
    func getSelectedNumber() -> Int {
        
        // TODO: get number from picker
        return 0
    }
    
    func setSelectedNumber(number: Int, animated: Bool) {
        
        // TODO: set number in picker
    }
    
    // MARK: Action methods
    
    @IBAction func selectorButtonPressed(sender: UIButton) {
        
        if (isUpperButton(sender)) {
            
            let component = upperButtons.indexOfObject(sender)
            incrementComponent(component)
            
        } else {
            
            let component = bottomButtons.indexOfObject(sender)
            decrementComponent(component)
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
        pickerView.userInteractionEnabled = false
        addSubview(pickerView)
    }
    
    private func setupAndAddSelectorViews() {

        upperContainer = setupSelectorViewWithImage("arrow_up")
        upperButtons = buttonsInView(upperContainer)
        addSubview(upperContainer)

        bottomContainer = setupSelectorViewWithImage("arrow_down")
        bottomButtons = buttonsInView(bottomContainer)
        addSubview(bottomContainer)
    }
    
    private func setupSelectorViewWithImage(imageName: String) -> UIView {
        
        let frame = CGRectMake(0, 0, 0, 0)
        let selectorView = UIView(frame: frame)
        selectorView.translatesAutoresizingMaskIntoConstraints = false
        
        let image: UIImage = UIImage(imageLiteral: imageName)
        
        for _ in 1 ... pickerNumberOfComponents {
            
            let button = UIButton(frame: CGRectMake(0, 0, buttonSize, buttonSize))
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(image, forState: UIControlState.Normal)
            selectorView.addSubview(button)
            
            button.addTarget(self, action: "selectorButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        return selectorView
    }
    
    private func buttonsInView(view: UIView) -> NSArray {
    
        var buttons: [UIButton] = Array()
        
        for subview in view.subviews {
            
            if subview.isKindOfClass(UIButton) {
                buttons.append(subview as! UIButton)
            }
        }
        
        return buttons
    }
    
    private func updatePickerConstraints() {
        
        ConstraintHelper.centerInSuperview(pickerView)
        ConstraintHelper.sameSizeThanSuperview(pickerView)
    }
    
    private func updateUpperContainerConstraints() {
        
        ConstraintHelper.viewHeight(upperContainer, equalsTo: containerHeight)
        ConstraintHelper.equalWidthInView(upperContainer, thanInView: pickerView)
        ConstraintHelper.equalLeadingForViews(upperContainer, view2: pickerView)
        ConstraintHelper.topSpaceToContainer(upperContainer, equalTo: 0)
        
        updateButtonsConstraints(upperButtons)
    }
    
    private func updateBottomContainerConstraints() {
        
        ConstraintHelper.viewHeight(bottomContainer, equalsTo: containerHeight)
        ConstraintHelper.equalWidthInView(bottomContainer, thanInView: pickerView)
        ConstraintHelper.equalLeadingForViews(bottomContainer, view2: pickerView)
        ConstraintHelper.bottomSpaceToContainer(bottomContainer, equalTo: 0.0)
        
        updateButtonsConstraints(bottomButtons)
    }
    
    private func updateButtonsConstraints(buttons: NSArray) {
        
        var index = 1

        for oneButton in buttons as! [UIButton] {
            
            ConstraintHelper.centerVerticalyInSuperview(oneButton)
            
            let realPickerWidth = pickerComponentWidth + pickerComponentExtraWidth
            let availableSpace = pickerComponentWidth - buttonSize
            
            if index == 1 {
                
                let horizontalSpace = realPickerWidth + availableSpace
                ConstraintHelper.horizontalSpaceToParent(oneButton, equalTo: horizontalSpace)
                
            } else {
                
                let horizontalSpace = (realPickerWidth * CGFloat(index)) + availableSpace
                ConstraintHelper.horizontalSpaceToParent(oneButton, equalTo: horizontalSpace)
            }
            
            index++
        }
    }
    
    private func isUpperButton(button: UIButton) -> Bool {
        
        return (upperButtons.indexOfObject(button) != NSNotFound)
    }
    
    private func incrementComponent(component: Int) {
        
        let newSelectedRow = pickerView.selectedRowInComponent(component) + 1
        pickerView.selectRow(newSelectedRow, inComponent: component, animated: true)
    }
    
    private func decrementComponent(component: Int) {
        
        let newSelectedRow = pickerView.selectedRowInComponent(component) - 1
        pickerView.selectRow(newSelectedRow, inComponent: component, animated: true)
    }
}
