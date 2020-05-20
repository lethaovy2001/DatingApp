//
//  SwipeCardViewTest.swift
//  DatingAppTests
//
//  Created by Vy Le on 5/20/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import XCTest
@testable import DatingApp

class SwipeCardViewTest: XCTestCase {
    private var cardImages: [UIImage]!
    private var currentImage: Int!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        cardImages = []
        currentImage = 0
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cardImages = []
        currentImage = 0
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testLeftNextImageWhenEmpty() {
        //Given
        XCTAssertEqual(cardImages.count, 0)
        XCTAssertEqual(currentImage, 0)

        //When
        testNextImage(isLeft: true)

        // Then
        XCTAssertEqual(currentImage, 0)
    }
    
    func testRightNextImageWhenEmpty() {
        //Given
        XCTAssertEqual(cardImages.count, 0)
        XCTAssertEqual(currentImage, 0)
        
        //When
        testNextImage(isLeft: false)
        
        // Then
        XCTAssertEqual(currentImage, 0)
    }
    
    func testNextImageForOne() {
        //Given
        cardImages.append(UIImage(named: "user")!)
        
        //When
        testNextImage(isLeft: false)
        testNextImage(isLeft: true)
        
        // Then
        XCTAssertEqual(currentImage, 0)
    }
    
    func testLeftNextImageForTwo() {
        //Given
        cardImages.append(UIImage(named: "user")!)
        cardImages.append(UIImage(named: "user")!)
        
        //When
        testNextImage(isLeft: true)
        
        // Then
        XCTAssertEqual(currentImage, 1)
    }
    
    func testRightNextImageForTwo() {
        //Given
        cardImages.append(UIImage(named: "user")!)
        cardImages.append(UIImage(named: "user")!)
        
        //When
        testNextImage(isLeft: false)
        
        // Then
        XCTAssertEqual(currentImage, 1)
    }
    
    func testLeftNextImageForThree() {
        cardImages.append(UIImage(named: "user")!)
        cardImages.append(UIImage(named: "user")!)
        cardImages.append(UIImage(named: "user")!)
        
        testNextImage(isLeft: true)
        XCTAssertEqual(currentImage, 2)
        
        testNextImage(isLeft: true)
        XCTAssertEqual(currentImage, 1)
        
        testNextImage(isLeft: true)
        XCTAssertEqual(currentImage, 0)
        
        testNextImage(isLeft: true)
        XCTAssertEqual(currentImage, 2)
    }
    
    func testRightNextImageForThree() {
        cardImages.append(UIImage(named: "user")!)
        cardImages.append(UIImage(named: "user")!)
        cardImages.append(UIImage(named: "user")!)
        
        testNextImage(isLeft: false)
        XCTAssertEqual(currentImage, 1)
        
        testNextImage(isLeft: false)
        XCTAssertEqual(currentImage, 2)
        
        testNextImage(isLeft: false)
        XCTAssertEqual(currentImage, 0)
        
        testNextImage(isLeft: false)
        XCTAssertEqual(currentImage, 1)
    }
    
    func testLeftRightNextImage() {
        cardImages.append(UIImage(named: "user")!)
        cardImages.append(UIImage(named: "user")!)
        cardImages.append(UIImage(named: "user")!)
        
        testNextImage(isLeft: true)
        XCTAssertEqual(currentImage, 2)
        
        testNextImage(isLeft: false)
        XCTAssertEqual(currentImage, 0)
        
        testNextImage(isLeft: false)
        XCTAssertEqual(currentImage, 1)
        
        testNextImage(isLeft: true)
        XCTAssertEqual(currentImage, 0)
    }
    
    func testNextImage(isLeft: Bool) {
        if cardImages.count < 1 {
            return
        }
        if (isLeft) {
            if (currentImage <= 0) {
                currentImage = cardImages.count - 1
            } else {
                currentImage = currentImage - 1
            }
        } else {
            if (currentImage == cardImages.count - 1) {
                currentImage = 0
            } else {
                currentImage = currentImage + 1
            }
        }
    }
}
