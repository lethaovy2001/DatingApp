//
//  ListMessageUITests.swift
//  DatingAppUITests
//
//  Created by Vy Le on 5/26/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import XCTest
@testable import DatingApp

class ListMessageUITests: XCTestCase {
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
    func testExistUI() {
        app.launch()
        app.buttons["messageButton"].tap()
        sleep(5)
        XCTAssertFalse(app.isDisplayingMain)
        XCTAssertTrue(app.isDisplayingListMessage)
        
        let navigationTitle = app.staticTexts["navigationTitle"]
        let backButton = app.buttons["navigationLeftItem"]
        let nameLabel = app.staticTexts["nameLabel"]
        let chatLabel = app.staticTexts["chatLabel"]
        let profileImageView = app.images["profileImageView"]
        
        XCTAssertTrue(navigationTitle.exists)
        XCTAssertTrue(backButton.exists)
        XCTAssertTrue(nameLabel.exists)
        XCTAssertTrue(chatLabel.exists)
        XCTAssertTrue(profileImageView.exists)
        
        nameLabel.firstMatch.tap()
        sleep(2)
        XCTAssertFalse(app.isDisplayingListMessage)
        XCTAssertTrue(app.isDisplayingChat)
    }
    
    func testBackButton() {
        app.launch()
        app.buttons["messageButton"].tap()
        app.buttons["navigationLeftItem"].tap()
        sleep(2)
        XCTAssertFalse(app.isDisplayingListMessage)
        XCTAssertTrue(app.isDisplayingMain)
    }

}
