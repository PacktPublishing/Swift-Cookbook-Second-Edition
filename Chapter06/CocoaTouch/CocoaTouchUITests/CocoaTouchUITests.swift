//
//  CocoaTouchUITests.swift
//  CocoaTouchUITests
//
//  Created by Chris Barker on 04/12/2020.
//

import XCTest

class CocoaTouchUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws { }

    func testThatUsernameSearchBarIsAvailable() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Grab the UITextView
        let textField = app.textFields.element(matching: .textField, identifier: "input.textfield.username")
        textField.tap()
        textField.typeText("MrChrisBarker")
        
        // Press return on the keyboard
        app.keyboards.buttons["return"].tap()
        
        // Wait for TableView
        let tableView = app.tables.staticTexts["XcodeValidateJson"]
        XCTAssertTrue(tableView.waitForExistence(timeout: 5))
        
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
