//
//  ParserTests.swift
//  tissue
//
//  Created by Alex Fish on 07/06/2014.
//  Copyright (c) 2014 alexefish. All rights reserved.
//

import XCTest

class ParserTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testJSONIsParsed() {
        let data = "{\"Hello\":\"world\"}".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        let (response : AnyObject!, error) = Parser.parseJSON(data)

        XCTAssertNotNil(response, "JSON was not parsed")
    }

    func testInvalidJSONIsNotParsed() {
        let data = "asddsa".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        let (response : AnyObject!, error) = Parser.parseJSON(data)

        XCTAssertNotNil(error, "invalid JSON was parsed")
    }

    func testInvalidDataIsNotParsed() {
        let (response : AnyObject!, error) = Parser.parseJSON(NSData())

        XCTAssertNotNil(error, "invalid JSON was parsed")
    }

    func testStringsAreParsed() {
        let dictionary = ["Hello": "World"]
        let string = Parser.parseString(dictionary, key: "Hello")

        XCTAssertNotNil(string, "String was not parsed")
    }

    func testURLsAreParsed() {
        let dictionary = ["Hello": "http://hello.com"]
        let url = Parser.parseURL(dictionary, key: "Hello")

        XCTAssertNotNil(url, "URL was not parsed")
    }

    func testNumbersAreParsed() {
        let dictionary = ["Hello": NSNumber(int: 1)]
        let number = Parser.parseNumber(dictionary, key: "Hello")

        XCTAssertNotNil(number, "Number was not parsed")
    }
}
