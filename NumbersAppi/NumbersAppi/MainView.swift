//
//  MainView.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 14/02/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation
import UIKit

protocol MainViewDelegate {
    
    func didRequestNumber(number: Int, ofType type: ApiRequestType)
    
    func didRequestDate(month month: Int, day: Int)
    
    func didRequestRandomNumberWithType(type: ApiRequestType)
    
    func didRequestRandomDate()
}

class MainView: UIView, MainViewProtocol {
    
    @IBOutlet var view: UIView!
    @IBOutlet var typeSelector: UISegmentedControl!
    @IBOutlet var numberPickerView: NumberPickerView!
    @IBOutlet var datePickerView: DatePickerView!
    @IBOutlet var textResult: UILabel!
    @IBOutlet var doubleTapInfo: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var delegate: MainViewDelegate!
    
    private let animationDuration = 0.5
    
    private var selectorValues: [ApiRequestType] = []
    
    // MARK: - Lifecycle methods

    override func awakeFromNib() {
        super.awakeFromNib()

        NSBundle.mainBundle().loadNibNamed("MainView", owner: self, options: nil)
        view.frame = self.bounds
        addSubview(view)
        
        setupTypeSelector()
        setupTextResult()
        addTapGestures()
        
        doubleTapInfo.text = NSLocalizedString("DOUBLE_TAP", comment: "Info message for double tap and random number")
    }
    
    // MARK: - Action methods
    
    @IBAction func typeSelectorHasChanged() {

        if isDateSelectorActive() {
            showDateSelector()
        } else {
            showNumberSelector()
        }
    }
    
    func didDoubleTap(gesture: UITapGestureRecognizer) {
        
        if isDateSelectorActive() {
            
            delegate.didRequestRandomDate()
            
        } else {
            
            let index = typeSelector.selectedSegmentIndex
            let type = selectorValues[index]
            delegate.didRequestRandomNumberWithType(type)
        }
    }
    
    func didSingleTap(gesture: UITapGestureRecognizer) {

        if isDateSelectorActive() {
            
            let date = datePickerView.getDate()
            delegate.didRequestDate(month: date.month, day: date.day)

        } else {

            let index = typeSelector.selectedSegmentIndex
            let type = selectorValues[index]
            delegate.didRequestNumber(numberPickerView.getSelectedNumber(), ofType: type)
        }
    }
    
    // MARK: - MainViewProtocol methods
    
    func startLoading() {
    
        textResult.text = ""
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        
        activityIndicator.hidden = true
        activityIndicator.stopAnimating()
    }
    
    func showText(text: String) {
        
        textResult.text = text
    }
    
    func setNumber(number: Int) {
        
        numberPickerView.setSelectedNumber(number, animated: true)
    }
    
    func setDate(month month: Int, day: Int) {
        
        datePickerView.setDate(month: month, day: day)
    }
    
    // MARK: - Private methods
    
    private func setupTypeSelector() {
        
        let triviaTitle = NSLocalizedString("TYPE_TRIVIA", comment: "Trivia type in the selector")
        typeSelector.setTitle(triviaTitle, forSegmentAtIndex: 0)
        selectorValues.append(ApiRequestType.Trivia)
        
        let mathTitle = NSLocalizedString("TYPE_MATH", comment: "Math type in the selector")
        typeSelector.setTitle(mathTitle, forSegmentAtIndex: 1)
        selectorValues.append(ApiRequestType.Math)
        
        let yearTitle = NSLocalizedString("TYPE_YEAR", comment: "Year type in the selector")
        typeSelector.setTitle(yearTitle, forSegmentAtIndex: 2)
        selectorValues.append(ApiRequestType.Year)
        
        let dateTitle = NSLocalizedString("TYPE_DATE", comment: "Date type in the selector")
        typeSelector.setTitle(dateTitle, forSegmentAtIndex: 3)
        selectorValues.append(ApiRequestType.Date)
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
    
    private func addTapGestures() {
        
        let singleTap = UITapGestureRecognizer(target: self, action: "didSingleTap:")
        textResult.addGestureRecognizer(singleTap)

        let doubleTap = UITapGestureRecognizer(target: self, action: "didDoubleTap:")
        doubleTap.numberOfTapsRequired = 2
        textResult.addGestureRecognizer(doubleTap)
        
        singleTap.requireGestureRecognizerToFail(doubleTap)
    }
    
    private func setupTextResult() {
        
        textResult.layer.borderColor = UIColor.blackColor().CGColor;
        textResult.layer.borderWidth = 1.5
        textResult.layer.cornerRadius = 1
    }
    
    private func isDateSelectorActive() -> Bool {
        
        let index = typeSelector.selectedSegmentIndex
        return (selectorValues[index] == ApiRequestType.Date)
    }

}