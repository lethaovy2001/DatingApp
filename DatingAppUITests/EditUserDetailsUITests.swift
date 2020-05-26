//
//  EditUserDetailsUITests.swift
//  DatingAppUITests
//
//  Created by Vy Le on 5/25/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import XCTest
@testable import DatingApp

class EditUserDetailsUITests: XCTestCase {
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
        app.buttons["navigationRightItem"].tap()
        sleep(5)
        XCTAssertFalse(app.isDisplayingMain)
        XCTAssertTrue(app.isDisplayingEditUserDetails)
        
        let bioLabel = app.staticTexts["Bio"]
        let detailsLabel = app.staticTexts["Details"]
        let featuredLabel = app.staticTexts["Featured"]
        let bioTextView = app.textViews["bioTextView"]
        let workTextField = app.textFields["workTextField"]
        let imageButtonsContainerView = app.otherElements["imageButtonsContainerView"]
        let mainImage = app.images["mainImage"]
        let nameLabel = app.staticTexts["nameLabel"]
        let backButton = app.buttons["navigationLeftItem"]
        let navigationTitle = app.staticTexts["navigationTitle"]
        let saveButton = app.buttons["Save"]
        let logoutButton = app.buttons["Logout"]
        let errorLabel = app.staticTexts["errorLabel"]
        
        XCTAssertTrue(bioLabel.exists)
        XCTAssertTrue(backButton.exists)
        XCTAssertTrue(detailsLabel.exists)
        XCTAssertTrue(featuredLabel.exists)
        XCTAssertTrue(workTextField.exists)
        XCTAssertTrue(nameLabel.exists)
        XCTAssertTrue(imageButtonsContainerView.exists)
        XCTAssertTrue(mainImage.exists)
        XCTAssertTrue(bioTextView.exists)
        XCTAssertTrue(navigationTitle.exists)
        XCTAssertTrue(saveButton.exists)
        XCTAssertTrue(logoutButton.exists)
        XCTAssertFalse(errorLabel.exists)
    }
    
    func testBackButton() {
        app.launch()
        app.buttons["profileButton"].tap()
        app.buttons["navigationRightItem"].tap()
        app.buttons["navigationLeftItem"].tap()
        sleep(2)
        XCTAssertFalse(app.isDisplayingEditUserDetails)
        XCTAssertTrue(app.isDisplayingMain)
    }
    
    func testEditUserProfile() {
        app.launch()
        app.buttons["profileButton"].tap()
        sleep(2)
        app.buttons["navigationRightItem"].tap()
        
        let workTextField = app.textFields["workTextField"]
        let bioTextView = app.textViews["bioTextView"]
        let saveButton = app.buttons["Save"]
        let workText = "work"
        let bioText = "bio"
        let view = app.otherElements["editUserDetailsView"]
        workTextField.tap()
        workTextField.typeText(workText)
        
        bioTextView.tap()
        bioTextView.typeText(bioText)
        view.tap()
        view.swipeUp()
        saveButton.tap()
    }
    
    func testInvalidInput() {
        app.launch()
        app.buttons["profileButton"].tap()
        app.buttons["navigationRightItem"].tap()
        sleep(2)
        
        let workTextField = app.textFields["workTextField"]
        let bioTextView = app.textViews["bioTextView"]
        let errorLabel = app.staticTexts["errorLabel"]
        let saveButton = app.buttons["Save"]
        let bioText = "bio"
        let view = app.otherElements["editUserDetailsView"]
        
        workTextField.tap()
        workTextField.clearText()
        
        bioTextView.tap()
        bioTextView.typeText(bioText)
        view.tap()
        view.swipeUp()
        saveButton.tap()
        XCTAssertTrue(errorLabel.exists)
    }
    
    func testLogout() {
        app.launch()
        app.buttons["profileButton"].tap()
        app.buttons["navigationRightItem"].tap()
        sleep(4)
        
        let view = app.otherElements["editUserDetailsView"]
        let logoutButton = app.buttons["Logout"]
        
        XCTAssertTrue(app.isDisplayingEditUserDetails)
        view.swipeUp()
        logoutButton.tap()
        XCTAssertFalse(app.isDisplayingEditUserDetails)
        XCTAssertTrue(app.isDisplayingLogin)
    }
}
