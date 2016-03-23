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
    var number: Int = 0
    var day: Int = 1
    var month: Int = 1
    var isRandom: Bool = false

    // MARK: - Lifecycle methods
    
    convenience init(type: ApiRequestType, number: Int) {
        
        self.init()
        
        self.type = type
        self.number = number
    }
    
    convenience init(month: Int, day: Int) {
        
        self.init()
        
        self.type = ApiRequestType.Date
        self.month = month
        self.day = day
    }
    
    convenience init(type: ApiRequestType) {
        
        self.init()
        
        self.type = type
        self.isRandom = true
    }
    
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