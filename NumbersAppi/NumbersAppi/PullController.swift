//
//  PullController.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 17/02/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation
import UIKit

class PullController {

    var pullableView: UIView
    var translucentView: UIView
    var delegate: PullControllerDelegate?
    
    // MARK: - Lifecycle methods
    
    init(pullableView: UIView, translucentView: UIView, delegate: PullControllerDelegate) {
        
        self.pullableView = pullableView
        self.translucentView = translucentView
        self.delegate = delegate

        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: "didTap")
        self.pullableView.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func didTap() {
        
        delegate?.viewWasPulled()
    }
}