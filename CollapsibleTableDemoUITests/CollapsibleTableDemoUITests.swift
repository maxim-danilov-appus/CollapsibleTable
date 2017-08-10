//
//  CollapsibleTableDemoUITests.swift
//  CollapsibleTableDemoUITests
//
//  Created by Robert Nash on 10/08/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//

import XCTest

class CollapsibleTableDemoUITests: XCTestCase
{
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
    }
    
    private let isHidden = "1"
    private let isOpen = "0"
    
    func testCollapse() {
        app.launchArguments.append("instruction:" + isHidden + ":" + isHidden + ":" + isOpen)
        app.launch()
        XCTAssert(app.tables.cells.count > 0)
        app.tables.otherElements["Vegetables"].children(matching: .other).element.tap()
        sleep(1)
        XCTAssert(self.app.tables.cells.count == 0)
    }
    
    func testExpand() {
        app.launchArguments.append("instruction:" + isHidden + ":" + isHidden + ":" + isHidden)
        app.launch()
        XCTAssert(app.tables.cells.count == 0)
        app.tables.otherElements["Vegetables"].children(matching: .other).element.tap()
        sleep(1)
        XCTAssert(self.app.tables.cells.count > 0)
    }
}
