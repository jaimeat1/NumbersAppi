//
//  MainViewControllerDelegate.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 14/02/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation
import UIKit

protocol MainViewControllerDelegate {
    
    func startLoading()
    
    func stopLoading()
    
    func showErrorMessage(message: String)
    
    func showTextResponse(text: String)
    
    func setNumber(number: Int)
    
    func setDate(month month: Int, day: Int)
}