//
//  MainView.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 14/02/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation
import UIKit

class MainView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet var typeSelector: UISegmentedControl!
    @IBOutlet var numberPickerView: NumberPickerView!
    @IBOutlet var datePickerView: DatePickerView!
    @IBOutlet var textResult: UILabel!
    
    private let animationDuration = 0.5
    
    private var dateTypeIndex: Int!
    
    // MARK: - Lifecycle methods

    override func awakeFromNib() {
        super.awakeFromNib()

        NSBundle.mainBundle().loadNibNamed("MainView", owner: self, options: nil)
        view.frame = self.bounds
        addSubview(view)
        
        setupTypeSelector()
        setupTextResult()
        addDoubleTapGesture()
    }
    
    // MARK: - Action methods
    
    @IBAction func typeSelectorHasChanged() {

        if typeSelector.selectedSegmentIndex == dateTypeIndex {
            showDateSelector()
        } else {
            showNumberSelector()
        }
    }
    
    func didDoubleTap(gesture: UITapGestureRecognizer) {
        
        // TODO: do animation
        // TODO: launch random request
    }
    
    // MARK: - Private methods
    
    private func setupTypeSelector() {
        
        let triviaTitle = NSLocalizedString("TYPE_TRIVIA", comment: "Trivia type in the selector")
        typeSelector.setTitle(triviaTitle, forSegmentAtIndex: 0)
        
        let mathTitle = NSLocalizedString("TYPE_MATH", comment: "Math type in the selector")
        typeSelector.setTitle(mathTitle, forSegmentAtIndex: 1)
        
        let yearTitle = NSLocalizedString("TYPE_YEAR", comment: "Year type in the selector")
        typeSelector.setTitle(yearTitle, forSegmentAtIndex: 2)
        
        let dateTitle = NSLocalizedString("TYPE_DATE", comment: "Date type in the selector")
        typeSelector.setTitle(dateTitle, forSegmentAtIndex: 3)
        dateTypeIndex = 3
    }
    
    private func showNumberSelector() {
        
        UIView.animateWithDuration(animationDuration) { () -> Void in
            
            self.numberPickerView.alpha = 1
            self.datePickerView.alpha = 0
        }
    }
    
    private func showDateSelector() {
        
        UIView.animateWithDuration(animationDuration) { () -> Void in
            
            self.numberPickerView.alpha = 0
            self.datePickerView.alpha = 1
        }
    }
    
    private func addDoubleTapGesture() {
        
        let doubleTap = UITapGestureRecognizer(target: self, action: "didDoubleTap:")
        doubleTap.numberOfTapsRequired = 2
        textResult.addGestureRecognizer(doubleTap)
    }
    
    private func setupTextResult() {
        
        textResult.layer.borderColor = UIColor.blackColor().CGColor;
        textResult.layer.borderWidth = 1.5
        textResult.layer.cornerRadius = 1
    }

}