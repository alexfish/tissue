//
//  RepoTests.swift
//  tissue
//
//  Created by Alex Fish on 7/1/14.
//  Copyright (c) 2014 alexefish. All rights reserved.
//

import XCTest

class RepoTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testIssueURLIsReturned() {
        let repo = Repo(id: "100", title: "title")
        let url: NSURL = repo.url(Issue)
        let expected = NSURL(string: repo.issuesAPIPath(), relativeToURL: ClientURL.GitHub)

        XCTAssertEqual(expected, url, "Issue url was not returned")
    }

    func testDefaultURLIsReturned() {
        let repo = Repo()
        let url: NSURL = repo.url(Repo)

        let expected = NSURL(string: repo.defaultAPIPath(), relativeToURL: ClientURL.GitHub)

        XCTAssertEqual(expected, url, "Default URL was not returned")
    }
}
