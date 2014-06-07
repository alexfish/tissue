//
//  Issue.swift
//  tissue
//
//  Created by Alex Fish on 6/4/14.
//  Copyright (c) 2014 alexefish. All rights reserved.
//

import UIKit

enum State: Int {
    case closed = 0
    case open = 1
}

class Issue: Model {

    var state: State
    let title: String
    let body: String?
    let url: NSURL

    init(id: String, state: State, title: String, url: NSURL) {
        self.state = state
        self.title = title
        self.url = url

        super.init(id: id)
    }

    init(id: String, state: State, title: String, body: String?, url: NSURL) {
        self.state = state
        self.title = title
        self.body = body
        self.url = url

        super.init(id: id)
    }

    convenience init(id: String, title: String, body: String, url: NSURL) {
        self.init(id: id, state: State.open, title: title, body: body, url: url)
    }

    convenience init(id: String, title: String, url: NSURL) {
        self.init(id: id, state: State.open, title: title, url: url)
    }

    func description() -> String {
        return "Issue is title: \(title), state: \(state), body: \(body), url: \(url)"
    }
}
