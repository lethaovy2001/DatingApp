//
//  MainUITests.swift
//  DatingAppUITests
//
//  Created by Vy Le on 5/25/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import XCTest
@testable import DatingApp

class MainUITests: XCTestCase {
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
        XCTAssertTrue(app.isDisplayingMain)
        
        let profileButton = app.buttons["profileButton"]
        let messageButton = app.buttons["messageButton"]
        let likeButton = app.buttons["likeButton"]
        let dislikeButton = app.buttons["dislikeButton"]
        
        XCTAssertTrue(app.isDisplayingSearchingAnimation)
        XCTAssertTrue(profileButton.exists)
        XCTAssertTrue(messageButton.exists)
        XCTAssertTrue(likeButton.exists)
        XCTAssertTrue(dislikeButton.exists)
    }
    
    func testSwipe() {
        let stackContainer = app.otherElements["swipeCardStackContainer"]
        XCTAssertTrue(stackContainer.exists)
        sleep(5)
        stackContainer.tap()
        stackContainer.tap()
        XCTAssertTrue(stackContainer.exists)
        
        stackContainer.swipeLeft()
        stackContainer.swipeRight()
        XCTAssertTrue(stackContainer.exists)
    }
    
    func testLikeButton() {
        app.launch()
        XCTAssertTrue(app.isDisplayingMain)
    
        let stackContainer = app.otherElements["swipeCardStackContainer"]
        let likeButton = app.buttons["likeButton"]
        
        XCTAssertTrue(stackContainer.exists)
        XCTAssertTrue(likeButton.exists)
        
        sleep(5)
        likeButton.tap()
        XCTAssertTrue(stackContainer.exists)
    }
    
    func testDislikeButton() {
        app.launch()
        XCTAssertTrue(app.isDisplayingMain)
    
        let stackContainer = app.otherElements["swipeCardStackContainer"]
        let dislikeButton = app.buttons["dislikeButton"]
        
        XCTAssertTrue(stackContainer.exists)
        XCTAssertTrue(dislikeButton.exists)
        
        sleep(5)
        dislikeButton.tap()
        XCTAssertTrue(stackContainer.exists)
    }
}
