//
//  SignUpUITests.swift
//  DatingAppUITests
//
//  Created by Vy Le on 5/25/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import XCTest

class SignUpUITests: XCTestCase {
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

    func testSignUpWithEmail() {
        app.launch()
        XCTAssertTrue(app.isDisplayingLogin)
        
        app.buttons["Sign Up"].tap()
        XCTAssertTrue(app.isDisplayingSignUp)
        
        let validName = "Vy"
        let validEmail = "vy@gmail.com"
        let validPassword = "123456"
        let nameTextField = app.textFields["Name"]
        let emailTextField = app.textFields["Email"]
        let passwordTextField = app.secureTextFields["Password"]
        let signUpButton = app.buttons["SIGN UP"]
        
        XCTAssertTrue(app.isDisplayingAppLogo)
        XCTAssertTrue(nameTextField.exists)
        XCTAssertTrue(emailTextField.exists)
        XCTAssertTrue(passwordTextField.exists)
        XCTAssertTrue(signUpButton.exists)
        
        nameTextField.tap()
        nameTextField.typeText(validName)
        emailTextField.tap()
        emailTextField.typeText(validEmail)
        passwordTextField.tap()
        passwordTextField.typeText(validPassword)
        signUpButton.tap()
        sleep(10)
        XCTAssertFalse(app.isDisplayingEmailLogin)
    }
    
    func testInvalidSignUp() {
        app.launch()
        XCTAssertTrue(app.isDisplayingLogin)
        
        app.buttons["Sign Up"].tap()
        XCTAssertTrue(app.isDisplayingSignUp)
        
        let validName = "Test1"
        let validEmail = "Test1@gmail.com"
        let validPassword = "123456"
        let nameTextField = app.textFields["Name"]
        let emailTextField = app.textFields["Email"]
        let passwordTextField = app.secureTextFields["Password"]
        let signUpButton = app.buttons["SIGN UP"]
        let errorLabel = app.staticTexts["The email address is already in use by another account."]
        
        XCTAssertTrue(app.isDisplayingAppLogo)
        XCTAssertTrue(nameTextField.exists)
        XCTAssertTrue(emailTextField.exists)
        XCTAssertTrue(passwordTextField.exists)
        XCTAssertTrue(signUpButton.exists)
        XCTAssertFalse(errorLabel.exists)
        
        nameTextField.tap()
        nameTextField.typeText(validName)
        emailTextField.tap()
        emailTextField.typeText(validEmail)
        passwordTextField.tap()
        passwordTextField.typeText(validPassword)
        signUpButton.tap()
        sleep(10)
        XCTAssertTrue(errorLabel.exists)
        XCTAssertTrue(app.isDisplayingSignUp)
    }
}
