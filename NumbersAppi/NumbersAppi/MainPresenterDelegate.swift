//
//  MainPresenterDelegate.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 14/02/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation
import UIKit

protocol MainPresenterDelegate {
    
    func didRequestNumber(number: Int)
    
    func didRequestDate(month month: Int, day: Int)
    
    func didRequestRandomNumber()
    
    func didRequestRandomDate()
    
    func userSelectedAbout()
}