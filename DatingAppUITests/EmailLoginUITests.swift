//
//  EmailLoginUITests.swift
//  DatingAppUITests
//
//  Created by Vy Le on 5/22/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import XCTest
@testable import DatingApp

//var app: XCUIApplication!
class EmailLoginUITests: XCTestCase {
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

    func testLoginWithEmail() {
        app.launch()
        XCTAssertTrue(app.isDisplayingLogin)
        
        app.buttons["LOG IN WITH EMAIL"].tap()
        XCTAssertTrue(app.isDisplayingEmailLogin)
        
        let validEmail = "Test1@gmail.com"
        let validPassword = "123456"
        let emailTextField = app.textFields["Email"]
        let passwordTextField = app.secureTextFields["Password"]
        let loginButton = app.buttons["LOG IN"]
        
        XCTAssertTrue(emailTextField.exists)
        XCTAssertTrue(passwordTextField.exists)
        XCTAssertTrue(loginButton.exists)
        
        emailTextField.tap()
        emailTextField.typeText(validEmail)
        passwordTextField.tap()
        passwordTextField.typeText(validPassword)
        loginButton.tap()
        sleep(10)
        XCTAssertFalse(app.isDisplayingEmailLogin)
    }
    
    func testInvalidLoginWithEmail() {
        app.launch()
        XCTAssertTrue(app.isDisplayingLogin)
        app.buttons["LOG IN WITH EMAIL"].tap()
        XCTAssertTrue(app.isDisplayingEmailLogin)
        
        let emailTextField = app.textFields["Email"]
        let passwordTextField = app.secureTextFields["Password"]
        let loginButton = app.buttons["LOG IN"]
        let errorLabel = app.staticTexts["The password is invalid or the user does not have a password."]
        
        XCTAssertTrue(emailTextField.exists)
        XCTAssertTrue(passwordTextField.exists)
        XCTAssertTrue(loginButton.exists)
        XCTAssertFalse(errorLabel.exists)
        
        loginButton.tap()
        XCTAssertTrue(errorLabel.exists)
    }
}
