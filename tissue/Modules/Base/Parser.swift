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

    class func parser(type: AnyClass) -> Parser {
        var parser: Parser

        if type is Issue.Type {
            parser = IssueParser()
        } else if type is Repo.Type {
            parser = RepoParser()
        } else {
            parser = Parser()
        }

        return parser
    }

    func parseJSON(data: NSData) -> (response: AnyObject!, error: NSError!) {

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
    
    func parseString(json: NSDictionary, key: String) -> String? {
        var value: String?

        if let response: AnyObject = json[key] {
            value = response as? String
        }

        return value
    }

    func parseNumber(json: NSDictionary, key: String) -> NSNumber? {
        var value: NSNumber?

        if let response: AnyObject = json[key] {
            value = response as? NSNumber
        }

        return value
    }

    func parseURL(json: NSDictionary, key: String) -> NSURL? {
        var value: NSURL?

        if let response: String = parseString(json, key: key) {
            value = NSURL(string: response)
        }

        return value
    }

    func parseObjects(json: AnyObject[]) -> AnyObject[] {

        var objects = json.filter{(var object) -> Bool in
            return self.parseObject(object as NSDictionary) != nil
        }.map({(var object) -> AnyObject in
            return self.parseObject(object as NSDictionary)!
        })

        return objects
    }

    func parseObject(json: NSDictionary) -> AnyObject? {
        /** Overwritten in subclasses */
        return nil
    }
}
