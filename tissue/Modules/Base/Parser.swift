//
//  Parser.swift
//  tissue
//
//  Created by Alex Fish on 07/06/2014.
//  Copyright (c) 2014 alexefish. All rights reserved.
//

import UIKit

struct ParserError {
    static let domain = "Parsing Error"
    static let code = 1000
    static let userInfo = NSDictionary(object: "There was an error parsing the JSON data", forKey: NSLocalizedDescriptionKey)
}

class Parser: NSObject {

    class func parseJSON(data: NSData) -> (response: AnyObject!, error: NSError!) {

        let parserError = NSError(domain: ParserError.domain, code: ParserError.code, userInfo: ParserError.userInfo)
        var error: NSError?

        if let json : AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) {
            if !error {
                return(json, nil)
            } else {
                return(nil, parserError)
            }
        } else {
            return(nil, parserError)
        }
    }

}
