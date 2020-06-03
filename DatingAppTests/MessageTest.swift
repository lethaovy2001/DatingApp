//
//  MessageTest.swift
//  DatingAppTests
//
//  Created by Vy Le on 5/21/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import XCTest
@testable import DatingApp

class MessageTest: XCTestCase {
    private var message: Message!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        message = nil
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
    
    func testMessageInfo() {
        let date = Date()
        let size: CGFloat = 10
        let dictionary: [String: Any] = [
            "messageId": "messageId",
            "fromId": "fromId",
            "toId": "toId",
            "time": date,
            "text": "text",
            "imageUrl": "imageUrl",
            "imageWidth": size,
            "imageHeight": size,
            "videoUrl": "videoUrl",
        ]
        message = Message(dictionary: dictionary)
        XCTAssertEqual(message.messageId, "messageId")
        XCTAssertEqual(message.fromId, "fromId")
        XCTAssertEqual(message.toId, "toId")
        XCTAssertEqual(message.time, date)
        XCTAssertEqual(message.text, "text")
        XCTAssertEqual(message.imageUrl, "imageUrl")
        XCTAssertEqual(message.imageWidth, size)
        XCTAssertEqual(message.imageHeight, size)
        XCTAssertEqual(message.videoUrl, "videoUrl")
    }
}
