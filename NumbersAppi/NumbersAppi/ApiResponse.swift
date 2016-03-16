//
//  ApiResponse.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 07/02/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation

class ApiResponse {
    
    var text: String = ""
    var found: Bool = true
    var number: Int = 0
    var type: ApiRequestType = ApiRequestType.Trivia
    
    // MARK: - Public methods
    
    func setFromJSON(json: NSDictionary) {
        
        text = json["text"] as! String
        found = json["found"] as! Bool
        number = json["number"] as! NSInteger
 
        switch json["type"] as! String {
            
        case ApiRequestType.Trivia.rawValue:
            type = ApiRequestType.Trivia
        case ApiRequestType.Math.rawValue:
            type = ApiRequestType.Math
        case ApiRequestType.Date.rawValue:
            type = ApiRequestType.Date
        case ApiRequestType.Year.rawValue:
            type = ApiRequestType.Year
        default:
            type = ApiRequestType.Unknown
        }
    }

}