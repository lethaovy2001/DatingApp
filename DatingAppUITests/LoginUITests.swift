//
//  LoginUITests.swift
//  DatingAppUITests
//
//  Created by Vy Le on 5/25/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import XCTest
@testable import DatingApp

class LoginUITests: XCTestCase {
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
    func testExitsUI() {
        app.launch()
        XCTAssertTrue(app.isDisplayingLogin)
        
        let emailLoginButton = app.buttons["LOG IN WITH EMAIL"]
        let facebookButton = app.buttons["LOG IN WITH FACEBOOK"]
        let errorLabel = app.staticTexts["Don't have an account?"]
        let signInButton = app.buttons["Sign In"]
        
        XCTAssertTrue(app.isDisplayingAppLogo)
        XCTAssertTrue(emailLoginButton.exists)
        XCTAssertTrue(facebookButton.exists)
        XCTAssertTrue(errorLabel.exists)
        XCTAssertTrue(signInButton.exists)
    }
    
    func testLoginWithFacebook() {
        let facebookButton = app.buttons["LOG IN WITH FACEBOOK"]
        facebookButton.tap()
        XCTAssertFalse(app.isDisplayingEmailLogin)
    }
}
