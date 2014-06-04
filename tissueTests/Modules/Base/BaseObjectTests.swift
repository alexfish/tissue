//
//  BaseObjectTests.swift
//  tissue
//
//  Created by Alex Fish on 6/4/14.
//  Copyright (c) 2014 alexefish. All rights reserved.
//

import XCTest

class BaseObjectTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testObjectIDIsSet() {
        let expectedValue = "Hello"
        let object: BaseObject = BaseObject(objectID: expectedValue)
        
        XCTAssertEqual(expectedValue, object.objectID, "ObjectID was not set")
    }

}
