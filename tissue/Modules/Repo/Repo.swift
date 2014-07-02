//
//  Repo.swift
//  tissue
//
//  Created by Alex Fish on 05/06/2014.
//  Copyright (c) 2014 alexefish. All rights reserved.
//

import UIKit

class Repo: Model {

    let title: String

    init(id: String, title: String) {
        self.title = title

        super.init(id: id)
    }

    convenience init() {
        self.init(id: String(), title: String())
    }

    func url(type: AnyClass) -> NSURL {
        var url: NSURL

        if type is Issue.Type {
            url = NSURL(string: issuesAPIPath(), relativeToURL: ClientURL.GitHub)
        } else {
            url = NSURL(string: defaultAPIPath(), relativeToURL: ClientURL.GitHub)
        }

        return url
    }

    func issuesAPIPath() -> String {
        return "repos/\(self.id)/issues"
    }

    func defaultAPIPath() -> String {
        return "repositories"
    }
}
