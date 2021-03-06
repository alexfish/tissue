//
//  IssueParserTests.swift
//  tissue
//
//  Created by Alex Fish on 07/06/2014.
//  Copyright (c) 2014 alexefish. All rights reserved.
//

import XCTest

class IssueParserTests: XCTestCase {

    let validJson = [IssueAPIKey.body: "body",
                     IssueAPIKey.title: "title",
                     IssueAPIKey.url: "http://foo.com",
                     IssueAPIKey.state: "open",
                     IssueAPIKey.id: 1]

    let parser = IssueParser()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func parsedIssue() -> Issue {
        let issue: Issue? = parser.parseObject(validJson) as? Issue
        return issue!
    }

    func testIssueTitleIsParsed() {
        XCTAssertEqual("title", parsedIssue().title, "Title was not parsed")
    }

    func testIssueBodyIsParsed() {
        let body: String? = parsedIssue().body
        XCTAssertEqual("body", body!, "Body was not parsed")
    }

    func testIssueIdIsParsed() {
        XCTAssertEqual("1", parsedIssue().id, "ID was not parsed")
    }

    func testIssueURLIsParsed() {
        let url: NSURL = parsedIssue().url
        XCTAssertEqual("http://foo.com", url.absoluteString!, "URL was not parsed")
    }

    func testIssueStateIsParsed() {
        XCTAssertEqual(State.open, parsedIssue().state, "Sate was not parsed")
    }

    func testIssuesAreParsed() {
        XCTAssertNotNil(parser.parseObjects([validJson]), "Issues were not parsed")
    }

    func testMissingBodyIsParsed() {
        var dictionary = NSMutableDictionary(dictionary: validJson)
        dictionary.removeObjectForKey(IssueAPIKey.body)

        XCTAssertNotNil(parser.parseObjects([dictionary]), "Invalid json was parsed")
    }

    func testAnInvalidJSONStringIsNotParsed() {
        (parser.parseObjects(["Hello"]).count == 0, "Invalid json was parsed")
    }

    func testMissingTitleIsNotParsed() {
        var dictionary = NSMutableDictionary(dictionary: validJson)
        dictionary.removeObjectForKey(IssueAPIKey.title)

        XCTAssertTrue(parser.parseObjects([dictionary]).count == 0, "Invalid json was parsed")
    }

    func testMissingURLIsNotParsed() {
        var dictionary = NSMutableDictionary(dictionary: validJson)
        dictionary.removeObjectForKey(IssueAPIKey.url)

        XCTAssertTrue(parser.parseObjects([dictionary]).count == 0, "Invalid json was parsed")
    }

    func testMissingIDIsNotParsed() {
        var dictionary = NSMutableDictionary(dictionary: validJson)
        dictionary.removeObjectForKey(IssueAPIKey.id)

        XCTAssertTrue(parser.parseObjects([dictionary]).count == 0, "Invalid json was parsed")
    }
}
