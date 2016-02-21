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
    
    private var dateTypeIndex: Int!
    
    // MARK: - Lifecycle methods

    override func awakeFromNib() {
        super.awakeFromNib()

        NSBundle.mainBundle().loadNibNamed("MainView", owner: self, options: nil)
        view.frame = self.bounds
        addSubview(view)
        
        setupTypeSelector()
    }
    
    // MARK: - Action methods
    
    @IBAction func typeSelectorHasChanged() {

        if typeSelector.selectedSegmentIndex == dateTypeIndex {
            // TODO: show date selector
        } else {
            // TODO: show common selector
        }
    }
    
    // MARK: - Private methods
    
    func setupTypeSelector() {
        
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

}