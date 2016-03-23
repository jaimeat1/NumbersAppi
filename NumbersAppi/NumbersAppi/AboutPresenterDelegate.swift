//
//  AboutPresenterDelegate.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 20/02/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation
import UIKit

protocol AboutPresenterDelegate {

    func backButtonPressed()
    
    func linkButtonPressed()
    
    func getVersion() -> String
}