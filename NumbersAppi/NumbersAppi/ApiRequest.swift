//
//  ApiRequest.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 07/02/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation

enum ApiRequestType: NSString {
    case Trivia = "trivia"
    case Math = "math"
    case Date = "date"
    case Year = "year"
    case Unknown = "unknown"
}

class ApiRequest {
    
    private let random = "random"
    
    var type: ApiRequestType = .Trivia
    var number: NSInteger = 0
    var day: NSInteger = 1
    var month: NSInteger = 1
    var isRandom: Bool = false

    // MARK: - Public methods
    
    func parametrizedRequest() -> String {

        return firstParameter() + "/" + secondParameter()
    }
    
    // MARK: - Private methods
    
    private func firstParameter() -> String {
        
        var parameter: String
        
        if (isRandom) {
            parameter = random
        } else if (type == ApiRequestType.Date) {
            parameter = "\(month)" + "/" + "\(day)"
        } else {
            parameter = "\(number)"
        }
        
        return parameter
    }
    
    private func secondParameter() -> String {
    
        return (type.rawValue as String)
    }
    
}