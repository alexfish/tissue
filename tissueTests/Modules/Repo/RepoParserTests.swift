//
//  RepoParserTests.swift
//  tissue
//
//  Created by Alex Fish on 7/2/14.
//  Copyright (c) 2014 alexefish. All rights reserved.
//

import XCTest

class RepoParserTests: XCTestCase {

    let validJson = [RepoAPIKey.title: "repo title",
                     RepoAPIKey.id: 10210]

    let parser = RepoParser()

    func parsedRepo() -> Repo! {
        let repo: Repo? = parser.parseObject(validJson) as? Repo
        return repo
    }
    
    func testIDIsParsed() {
        XCTAssertNotNil(parsedRepo().id, "id was not parsed")
    }

    func testTitleIsParsed() {
        XCTAssertNotNil(parsedRepo().title, "title was not parsed")
    }

    func testInvalidJSONIsNotParsed() {
        XCTAssertNil(parser.parseObject(["asidj": "aisdjiasjf"]), "Invalid json was parsed")
    }
}
