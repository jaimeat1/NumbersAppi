//
//  ApiServices.swift
//  NumbersAppi
//
//  Created by Jaime Aranaz on 07/02/16.
//  Copyright © 2016 Jaime Aranaz. All rights reserved.
//

import Foundation

private let baseUrl = "http://numbersapi.com/"
private let jsonFlag = "?json"
// TODO: configure max and min whit a init method or similiar
private let maxMinFlag = "min=0&max=99999"

class ApiServices {
    
    static let sharedInstance = ApiServices()
    
    // MARK: - Public methods
    
    func sendRequest(request: ApiRequest, completion: (response: ApiResponse, error: NSError?) -> Void) {
        
        let requestUrl = baseUrl + request.parametrizedRequest() + jsonFlag + "&" + maxMinFlag
        let restRequest = NSMutableURLRequest(URL: NSURL(string: requestUrl)!)
        
        // TODO: use NSURLSessionConfiguration to create session and set a timeout value!!
        
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
            
            dispatch_async(dispatch_get_main_queue(), {
                completion(response: response, error: error)
            }) 
        })
        task.resume()
    }

}