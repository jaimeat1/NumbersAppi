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
    
    @IBOutlet var view:UIView!
    @IBOutlet var label:UILabel!
    
    // MARK: - Lifecycle methods

    override func awakeFromNib() {
        super.awakeFromNib()

        NSBundle.mainBundle().loadNibNamed("MainView", owner: self, options: nil)
        view.frame = self.bounds
        addSubview(view)
    }

}