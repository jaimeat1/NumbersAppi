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
    
    func didRequestNumber(_ number: Int, ofType type: ApiRequestType)
    
    func didRequestDate(month: Int, day: Int)
    
    func didRequestRandomNumberWithType(_ type: ApiRequestType)
    
    func didRequestRandomDate()
    
    func didHideWalkthrough()
}

class MainView: UIView, MainViewProtocol, WalkthroughControllerDelegate {
    
    @IBOutlet var view: UIView!
    @IBOutlet var typeSelector: UISegmentedControl!
    @IBOutlet var numberPickerView: NumberPickerView!
    @IBOutlet var datePickerView: DatePickerView!
    @IBOutlet var textResult: TextLabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var shadowView: UIView!
    @IBOutlet var singleTapView: UIView!
    @IBOutlet var singleTapInfo: UILabel!
    @IBOutlet var singleTapImage: UIImageView!
    @IBOutlet var doubleTapView: UIView!
    @IBOutlet var doubleTapInfo: UILabel!
    @IBOutlet var doubleTapImage: UIImageView!
    
    var walkthroughController: WalkthroughController!
    var delegate: MainViewDelegate!
    
    fileprivate let animationDuration = 0.5
    fileprivate let selectorFontSize: CGFloat = 14
    fileprivate let resultFontSize: CGFloat = 20
    
    fileprivate var singleTapGesture: UITapGestureRecognizer!
    fileprivate var doubleTapGesture: UITapGestureRecognizer!
    fileprivate var selectorValues: [ApiRequestType] = []
    
    // MARK: - Lifecycle methods

    override func awakeFromNib() {
        super.awakeFromNib()
        
        Bundle.main.loadNibNamed("MainView", owner: self, options: nil)
        view.frame = self.bounds
        addSubview(view)
        
        textResult.backgroundColor = UIColor.numbersBlueMedium()
        
        setupTypeSelector()
        setupTextResult()
        addTapGestures()
        
        let walkthroughViews = WalkthroughViews(
            textResult: textResult,
            shadowView: shadowView,
            singleTapView: singleTapView,
            singleTapInfo: singleTapInfo,
            singleTapImage: singleTapImage,
            doubleTapView:  doubleTapView,
            doubleTapInfo:  doubleTapInfo,
            doubleTapImage: doubleTapImage)
        
        walkthroughController = WalkthroughController(walkthroughViews: walkthroughViews, delegate: self)
    }
    
    // MARK: - Action methods
    
    @IBAction func typeSelectorHasChanged() {

        if isDateSelectorActive() {
            showDateSelector()
        } else {
            showNumberSelector()
        }
    }
    
    func didDoubleTap(_ gesture: UITapGestureRecognizer) {
        
        if isDateSelectorActive() {
            
            delegate.didRequestRandomDate()
            
        } else {
            
            let index = typeSelector.selectedSegmentIndex
            let type = selectorValues[index]
            delegate.didRequestRandomNumberWithType(type)
        }
    }
    
    func didSingleTap(_ gesture: UITapGestureRecognizer) {

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
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    func showText(_ text: String) {
        
        textResult.text = text
    }
    
    func setNumber(_ number: Int) {
        
        numberPickerView.setSelectedNumber(number, animated: true)
    }
    
    func setDate(month: Int, day: Int) {
        
        datePickerView.setDate(month: month, day: day)
    }
    
    func showWalkthrough() {
        
        removeTapGestures()
        walkthroughController.show()
    }
    
    func didViewLayout() {
        
        addShadowToTextResult()
    }
    
    // MARK: - WalkthroughControllerDelegate methods
    
    func didDismissWalkthrough() {
        
        delegate.didHideWalkthrough()
        addTapGestures()
    }
    
    // MARK: - Private methods
    
    fileprivate func setupTypeSelector() {
        
        let triviaTitle = NSLocalizedString("TYPE_TRIVIA", comment: "Trivia type in the selector").uppercased()
        typeSelector.setTitle(triviaTitle, forSegmentAt: 0)
        selectorValues.append(ApiRequestType.trivia)
        
        let mathTitle = NSLocalizedString("TYPE_MATH", comment: "Math type in the selector").uppercased()
        typeSelector.setTitle(mathTitle, forSegmentAt: 1)
        selectorValues.append(ApiRequestType.math)
        
        let yearTitle = NSLocalizedString("TYPE_YEAR", comment: "Year type in the selector").uppercased()
        typeSelector.setTitle(yearTitle, forSegmentAt: 2)
        selectorValues.append(ApiRequestType.year)
        
        let dateTitle = NSLocalizedString("TYPE_DATE", comment: "Date type in the selector").uppercased()
        typeSelector.setTitle(dateTitle, forSegmentAt: 3)
        selectorValues.append(ApiRequestType.date)
        
        typeSelector.backgroundColor = UIColor.numbersBlueDark()
        typeSelector.tintColor = UIColor.white
        typeSelector.layer.cornerRadius = 5
        typeSelector.layer.masksToBounds = true
        typeSelector.clipsToBounds = true
        
        let selectedAttributes = [NSFontAttributeName: UIFont.numbersBoldFontOfSize(selectorFontSize)]
        let unselectedAttributes = [NSFontAttributeName: UIFont.numbersNormalFontOfSize(selectorFontSize)]
        
        typeSelector.setTitleTextAttributes(selectedAttributes, for: UIControlState.selected)
        typeSelector.setTitleTextAttributes(unselectedAttributes, for: UIControlState())
    }
    
    fileprivate func showNumberSelector() {
        
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            
            self.numberPickerView.alpha = 1
            self.datePickerView.alpha = 0
        }) 
    }
    
    fileprivate func showDateSelector() {
        
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            
            self.numberPickerView.alpha = 0
            self.datePickerView.alpha = 1
        }) 
    }
    
    fileprivate func addTapGestures() {
        
        singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(MainView.didSingleTap(_:)))
        textResult.addGestureRecognizer(singleTapGesture)

        doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(MainView.didDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        textResult.addGestureRecognizer(doubleTapGesture)
        
        singleTapGesture.require(toFail: doubleTapGesture)
    }
    
    fileprivate func removeTapGestures() {
     
        textResult.removeGestureRecognizer(singleTapGesture)
        textResult.removeGestureRecognizer(doubleTapGesture)
    }
    
    fileprivate func setupTextResult() {
        
        textResult.layer.borderColor = UIColor.black.cgColor;
        textResult.layer.borderWidth = 0.5

        textResult.font = UIFont.numbersResponseFontOfSize(20)
    }
    
    fileprivate func addShadowToTextResult() {
        
        textResult.layer.shadowColor = UIColor.black.cgColor
        textResult.layer.shadowOffset = CGSize(width: 0, height: 1)
        textResult.layer.shadowOpacity = 0.5
        let shadowPath = UIBezierPath(rect: textResult.bounds)
        textResult.layer.shadowPath = shadowPath.cgPath
        textResult.layer.masksToBounds = false
        textResult.layer.shouldRasterize = true
    }
    
    fileprivate func isDateSelectorActive() -> Bool {
        
        let index = typeSelector.selectedSegmentIndex
        return (selectorValues[index] == ApiRequestType.date)
    }

}
