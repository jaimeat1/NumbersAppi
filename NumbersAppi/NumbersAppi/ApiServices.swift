//
//  ApiServices.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 07/02/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation

private let baseUrl = "http://numbersapi.com/dfe/"
private let jsonFlag = "?json"

class ApiServices {
    
    static let sharedInstance = ApiServices()
    
    // MARK: - Public methods
    
    func sendRequest(request: ApiRequest, completion: (response: ApiResponse, error: NSError?) -> Void) {
        
        let requestUrl = baseUrl + request.parametrizedRequest() + jsonFlag
        let restRequest = NSMutableURLRequest(URL: NSURL(string: requestUrl)!)
        
        let session = NSURLSession.sharedSession();
        let task = session.dataTaskWithRequest(restRequest, completionHandler: {data, response, error -> Void in

            let responseDictionary = try? NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
            
            let response = ApiResponse()
            var error: NSError?
            
            if (responseDictionary != nil) {
                response.setFromJSON(responseDictionary as! NSDictionary)
            } else {
                response.found = false
                error = NSError.init(domain: "", code: 0, userInfo: nil)
            }
            
            completion(response: response, error: error)
        })
        task.resume()
    }

}