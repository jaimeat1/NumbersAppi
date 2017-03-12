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
    var type: ApiRequestType = ApiRequestType.trivia
    
    // MARK: - Public methods
    
    func setFromJSON(_ json: NSDictionary) {
        
        text = json["text"] as! String
        found = json["found"] as! Bool
        number = json["number"] as! NSInteger
 
        switch json["type"] as! String {
            
        case ApiRequestType.trivia.rawValue as String:
            type = ApiRequestType.trivia
        case ApiRequestType.math.rawValue as String:
            type = ApiRequestType.math
        case ApiRequestType.date.rawValue as String:
            type = ApiRequestType.date
        case ApiRequestType.year.rawValue as String:
            type = ApiRequestType.year
        default:
            type = ApiRequestType.unknown
        }
    }

}
