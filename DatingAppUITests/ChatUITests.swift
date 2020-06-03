//
//  ChatUITests.swift
//  DatingAppUITests
//
//  Created by Vy Le on 5/26/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import XCTest
@testable import DatingApp

class ChatUITests: XCTestCase {
    var app: XCUIApplication!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()

        // Since UI tests are more expensive to run, it's usually a good idea
        // to exit if a failure was encountered
        continueAfterFailure = false

        app = XCUIApplication()
        
        // We send a command line argument to our app,
        // to enable it to reset its state
        app.launchArguments.append("--uitesting")
    }

    // MARK: - Tests
    func testSendMessage() {
        app.launch()
        app.buttons["messageButton"].tap()
        sleep(5)
        app.staticTexts["nameLabel"].firstMatch.tap()
        sleep(2)
        XCTAssertFalse(app.isDisplayingListMessage)
        XCTAssertTrue(app.isDisplayingChat)
        
        let backButton = app.buttons["navigationLeftItem"]
        let sendButton = app.buttons["sendButton"]
        let addImageButton = app.buttons["addImageButton"]
        let inputTextView = app.textViews["inputTextView"]
        let text = "Hello!"
        
        XCTAssertTrue(backButton.exists)
        XCTAssertTrue(sendButton.exists)
        XCTAssertTrue(inputTextView.exists)
        XCTAssertTrue(addImageButton.exists)
        
        inputTextView.tap()
        inputTextView.typeText(text)
        sendButton.tap()
    }
    
    func testNewConversation() {
        app.launch()
        app.buttons["messageButton"].tap()
        sleep(5)
        app.staticTexts["nameLabel"].firstMatch.tap()
        sleep(2)
        XCTAssertFalse(app.isDisplayingListMessage)
        XCTAssertTrue(app.isDisplayingChat)
        
        let alertView = app.otherElements["alertView"]
        let doneButton = app.buttons["DONE"]
        
        XCTAssertTrue(alertView.exists)
        XCTAssertTrue(doneButton.exists)
        
        doneButton.tap()
        XCTAssertTrue(app.isDisplayingChat)
    }
}
