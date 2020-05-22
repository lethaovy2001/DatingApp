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
    
    func testTextMessage() {
        let date = Date()
        let dictionary: [String: Any] = [
            "messageId": "messageId",
            "fromId": "fromId",
            "toId": "toId",
            "time": date,
            "text": "text"
        ]
        message = Message(dictionary: dictionary)
        XCTAssertEqual(message.messageId, "messageId")
        XCTAssertEqual(message.fromId, "fromId")
        XCTAssertEqual(message.toId, "toId")
        XCTAssertEqual(message.time, date)
        XCTAssertEqual(message.text, "text")
        XCTAssertEqual(message.imageUrl, nil)
        XCTAssertEqual(message.imageWidth, nil)
        XCTAssertEqual(message.imageHeight, nil)
        XCTAssertEqual(message.videoUrl, nil)
    }
    
    func testImageMessageInfo() {
        let date = Date()
        let size: CGFloat = 10
        let dictionary: [String: Any] = [
            "messageId": "messageId",
            "fromId": "fromId",
            "toId": "toId",
            "time": date,
            "imageUrl": "imageUrl",
            "imageWidth": size,
            "imageHeight": size,
        ]
        message = Message(dictionary: dictionary)
        XCTAssertEqual(message.messageId, "messageId")
        XCTAssertEqual(message.fromId, "fromId")
        XCTAssertEqual(message.toId, "toId")
        XCTAssertEqual(message.time, date)
        XCTAssertEqual(message.text, nil)
        XCTAssertEqual(message.imageUrl, "imageUrl")
        XCTAssertEqual(message.imageWidth, size)
        XCTAssertEqual(message.imageHeight, size)
    }
    
    func testVideoMessageInfo() {
        let date = Date()
        let size: CGFloat = 10
        let dictionary: [String: Any] = [
            "messageId": "messageId",
            "fromId": "fromId",
            "toId": "toId",
            "time": date,
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
        XCTAssertEqual(message.text, nil)
        XCTAssertEqual(message.imageUrl, "imageUrl")
        XCTAssertEqual(message.imageWidth, size)
        XCTAssertEqual(message.imageHeight, size)
        XCTAssertEqual(message.videoUrl, "videoUrl")
    }
    
    func testGetMessageDictionary() {
        let date = Date()
        let dictionary: [String: Any] = [
            "fromId": "fromId",
            "toId": "toId",
            "time": date,
            "text": "text",
        ]
        message = Message(dictionary: dictionary)
        let values = message.getMessageDictionary()!
        XCTAssertEqual(values["fromId"] as! String, "fromId")
        XCTAssertEqual(values["toId"] as! String, "toId")
        XCTAssertEqual(values["time"] as! Date, date)
        XCTAssertEqual(values["text"] as! String, "text")
    }
    
    func testGetImageMessageDictionary() {
        let date = Date()
        let size: CGFloat = 10
        let dictionary: [String: Any] = [
            "fromId": "fromId",
            "toId": "toId",
            "time": date,
            "imageUrl": "imageUrl",
            "imageWidth": size,
            "imageHeight": size,
        ]
        message = Message(dictionary: dictionary)
        let values = message.getMessageDictionary()!
        XCTAssertEqual(values["fromId"] as! String, "fromId")
        XCTAssertEqual(values["toId"] as! String, "toId")
        XCTAssertEqual(values["time"] as! Date, date)
        XCTAssertEqual(values["imageUrl"] as! String, "imageUrl")
        XCTAssertEqual(values["imageWidth"] as! CGFloat, size)
        XCTAssertEqual(values["imageHeight"] as! CGFloat, size)
    }
    
    func testGetVideoMessageDictionary() {
        let date = Date()
        let size: CGFloat = 10
        let dictionary: [String: Any] = [
            "fromId": "fromId",
            "toId": "toId",
            "time": date,
            "imageUrl": "imageUrl",
            "imageWidth": size,
            "imageHeight": size,
            "videoUrl": "videoUrl",
        ]
        message = Message(dictionary: dictionary)
        let values = message.getMessageDictionary()!
        XCTAssertEqual(values["fromId"] as! String, "fromId")
        XCTAssertEqual(values["toId"] as! String, "toId")
        XCTAssertEqual(values["time"] as! Date, date)
        XCTAssertEqual(values["imageUrl"] as! String, "imageUrl")
        XCTAssertEqual(values["imageWidth"] as! CGFloat, size)
        XCTAssertEqual(values["imageHeight"] as! CGFloat, size)
        XCTAssertEqual(values["videoUrl"] as! String, "videoUrl")
    }
}
