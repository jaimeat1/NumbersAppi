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
    
    func showErrorMessage(_ message: String)
    
    func showTextResponse(_ text: String)
    
    func setNumber(_ number: Int)
    
    func setDate(month: Int, day: Int)
}
