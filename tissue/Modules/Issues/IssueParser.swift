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

    func parseIssues(json: NSArray) -> Issue[] {
        var issues: Issue[] = []

        for object: AnyObject in json {
            if let issueJSON = object as? NSDictionary {
                if let issue = self.parseIssue(issueJSON) {
                    issues.append(issue)
                }
            }
        }

        return issues
    }

    func parseIssue(json: NSDictionary) -> Issue? {

        var issue: Issue?

        let title   = parseString(json, key: IssueAPIKey.title)
        let id      = parseNumber(json, key: IssueAPIKey.id)
        let url     = parseURL(json, key: IssueAPIKey.url)
        let body    = parseString(json, key: IssueAPIKey.body)

        if title? && id? && url? {
            issue = Issue(id: id!.stringValue, title: title!, body: body, url: url!)
        }

        return issue
    }
    
}
