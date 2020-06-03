//
//  PreferenceUITests.swift
//  DatingAppUITests
//
//  Created by Vy Le on 5/25/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import XCTest
@testable import DatingApp

class PreferenceUITests: XCTestCase {
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
        
        app.launch()
        app.buttons["Sign Up"].tap()
        
        let validName = "Vy6"
        let validEmail = "vy6@gmail.com"
        let validPassword = "123456"
        let nameTextField = app.textFields["Name"]
        let emailTextField = app.textFields["Email"]
        let passwordTextField = app.secureTextFields["Password"]
        let signUpButton = app.buttons["SIGN UP"]
        
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

    // MARK: - Tests
    func testPreferenceView() {
        XCTAssertTrue(app.isDisplayingPreference)
        let genderLabel = app.staticTexts["Gender"]
        let interestedInLabel = app.staticTexts["Interested in"]
        let birthdayLabel = app.staticTexts["Birthday"]
        let genderSegmentedControl = app.segmentedControls["genderSegmentedControl"]
        let interestedSegmentedControl = app.segmentedControls["interestedSegmentedControl"]
        let birthdayTextField = app.textFields["mm-dd-yyyy"]
        let saveButton = app.buttons["Save"]
        let validBirthday = "03-07-2001"
    
        XCTAssertTrue(genderSegmentedControl.exists)
        XCTAssertTrue(interestedSegmentedControl.exists)
        XCTAssertTrue(genderLabel.exists)
        XCTAssertTrue(interestedInLabel.exists)
        XCTAssertTrue(birthdayLabel.exists)
        XCTAssertTrue(birthdayTextField.exists)
        XCTAssertTrue(saveButton.exists)
        
        genderSegmentedControl.buttons["Male"].tap()
        birthdayTextField.tap()
        birthdayTextField.typeText(validBirthday)
        saveButton.tap()
        sleep(5)
        XCTAssertFalse(app.isDisplayingPreference)
    }
}
