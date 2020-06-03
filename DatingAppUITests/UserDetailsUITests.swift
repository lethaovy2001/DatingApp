//
//  UserDetailsUITests.swift
//  DatingAppUITests
//
//  Created by Vy Le on 5/25/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import XCTest
@testable import DatingApp

class UserDetailsUITests: XCTestCase {
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
        app.buttons["profileButton"].tap()
        sleep(1)
        XCTAssertFalse(app.isDisplayingMain)
        XCTAssertTrue(app.isDisplayingUserDetails)
        
        let bioLabel = app.staticTexts["Bio"]
        let backButton = app.buttons["navigationLeftItem"]
        let editButton = app.buttons["navigationRightItem"]
        let workButton = app.buttons["workButton"]
        let imageView = app.images["profileImageView"]
        let nameLabel = app.staticTexts["profileName"]
        let ageLabel = app.staticTexts["profileAge"]
        let workLabel = app.staticTexts["profileWork"]
        let bioTextView = app.textViews["bioTextView"]
        let navigationTitle = app.staticTexts["navigationTitle"]
        
        XCTAssertTrue(bioLabel.exists)
        XCTAssertTrue(backButton.exists)
        XCTAssertTrue(editButton.exists)
        XCTAssertTrue(workButton.exists)
        XCTAssertTrue(imageView.exists)
        XCTAssertTrue(nameLabel.exists)
        XCTAssertTrue(ageLabel.exists)
        XCTAssertTrue(workLabel.exists)
        XCTAssertTrue(bioTextView.exists)
        XCTAssertTrue(navigationTitle.exists)
    }
    
    func testBackButton() {
        app.launch()
        app.buttons["profileButton"].tap()
        app.buttons["navigationLeftItem"].tap()
        sleep(5)
        XCTAssertFalse(app.isDisplayingUserDetails)
        XCTAssertTrue(app.isDisplayingMain)
    }
}
