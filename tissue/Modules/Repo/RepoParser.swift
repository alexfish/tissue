//
//  RepoParser.swift
//  tissue
//
//  Created by Alex Fish on 7/2/14.
//  Copyright (c) 2014 alexefish. All rights reserved.
//

import UIKit

struct RepoAPIKey {
    static let title = "full_name"
    static let id = "id"
}

class RepoParser: Parser {

    override func parseObject(json: NSDictionary) -> AnyObject? {
        var repo: Repo?

        let title   = parseString(json, key: RepoAPIKey.title)
        let id      = parseNumber(json, key: RepoAPIKey.id)

        if title != nil && id != nil {
            repo = Repo(id: id!.stringValue, title: title!)
        }

        return repo
    }

}
