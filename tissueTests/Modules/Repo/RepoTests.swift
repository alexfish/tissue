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

    func testIssuePathIsReturned() {
        let repo = Repo(id: "100")
        let path: String = repo.path(Issue)

        XCTAssertEqual("repos/100/issues", path, "Issue path was not returned")
    }
}
