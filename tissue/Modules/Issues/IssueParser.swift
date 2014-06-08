//
//  IssueParser.swift
//  tissue
//
//  Created by Alex Fish on 07/06/2014.
//  Copyright (c) 2014 alexefish. All rights reserved.
//

import UIKit

struct IssueAPIKey {
    static let body = "body"
    static let title = "title"
    static let state = "state"
    static let id = "number"
    static let url = "url"
}

class IssueParser: Parser {

    class func parseIssues(json: NSArray) -> Issue[]? {
        var issues: Issue[] = []

        for object: AnyObject in json {
            if let issueJSON = object as? NSDictionary {
                if let issue = IssueParser.parseIssue(issueJSON) {
                    issues.append(issue)
                }
            }
        }

        return issues.count == 0 ? nil : issues
    }

    class func parseIssue(json: NSDictionary) -> Issue? {
        var body: String?
        var id: String
        var url: NSURL
        var issue: Issue

        let title = IssueParser.parseTitle(fromResponse: json)

        if let bodyResponse: AnyObject = json[IssueAPIKey.body] {
            body = bodyResponse as? String
        }

        if let idResponse: AnyObject = json[IssueAPIKey.id] {
            let idNumber = idResponse as NSNumber
            id = idNumber.stringValue
        } else {
            return nil
        }

        if let urlResponse: AnyObject = json[IssueAPIKey.url] {
            let urlString = urlResponse as  String
            url = NSURL(string: urlString)
        } else {
            return nil
        }

        if body {
            issue = Issue(id: id, title: title, body: body!, url: url)
        } else {
            issue = Issue(id: id, title: title, url: url)
        }

        return issue
    }

    class func parse<T>(json: NSDictionary, key: String) -> T {
        var value: T

        if let response: T = json[key] {
            value = response
        }

        return value
    }

    class func parseTitle(fromResponse json: NSDictionary) -> String? {
        var title: String?

        if let titleResponse: AnyObject = json[IssueAPIKey.title] {
            title = titleResponse as? String
        }

        return title
    }

}
