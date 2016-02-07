//
//  ApiRequest.swift
//  NumbersAppi
//
//  Created by Jaime on 07/02/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation

enum ApiRequestType: NSString {
    case Trivia = "trivia"
    case Math = "math"
    case Date = "date"
    case Year = "year"
}

class ApiRequest {
    
    var type: ApiRequestType = .Trivia
    var number: NSInteger = 0
    var day: NSInteger = 0
    var month: NSInteger = 0
    var random: Bool = false
    
}