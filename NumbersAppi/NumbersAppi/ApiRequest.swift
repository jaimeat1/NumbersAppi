//
//  ApiRequest.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 07/02/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation

enum ApiRequestType: String {
    case trivia = "trivia"
    case math = "math"
    case date = "date"
    case year = "year"
    case unknown = "unknown"
}

class ApiRequest {
    
    fileprivate let random = "random"
    
    var type: ApiRequestType = .trivia
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
        
        self.type = ApiRequestType.date
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
    
    fileprivate func firstParameter() -> String {
        
        var parameter: String
        
        if (isRandom) {
            parameter = random
        } else if (type == ApiRequestType.date) {
            parameter = "\(month)" + "/" + "\(day)"
        } else {
            parameter = "\(number)"
        }
        
        return parameter
    }
    
    fileprivate func secondParameter() -> String {
    
        return (type.rawValue as String)
    }
    
}
