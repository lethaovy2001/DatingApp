//
//  DatingAppUITests.swift
//  DatingAppUITests
//
//  Created by Vy Le on 5/22/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import XCTest
@testable import DatingApp

//var app: XCUIApplication!
class DatingAppUITests: XCTestCase {
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
        XCTAssertTrue(emailTextField.exists)
        emailTextField.tap()
        emailTextField.typeText(validEmail)
        XCTAssertTrue(emailTextField.exists)
        
        let passwordTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        passwordTextField.typeText(validPassword)
        
        let loginButton = app.buttons["LOG IN"]
        loginButton.tap()
        sleep(10)
        XCTAssertFalse(app.isDisplayingEmailLogin)
    }
}

extension XCUIApplication {
    var isDisplayingEmailLogin: Bool {
        return otherElements["emailLoginView"].exists
    }
    
    var isDisplayingLogin: Bool {
        return otherElements["loginView"].exists
    }
    
    var isDisplayingMain: Bool {
        return otherElements["mainView"].exists
    }
}
