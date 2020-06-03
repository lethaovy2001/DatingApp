//
//  MessageViewModelTest.swift
//  DatingAppTests
//
//  Created by Vy Le on 5/21/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import XCTest
@testable import DatingApp

class MessageViewModelTest: XCTestCase {
    private var viewModel: MessageViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
    
    func testTextMessageViewModel() {
        let date = Date()
        let dictionary: [String: Any] = [
            "messageId": "messageId",
            "fromId": "fromId",
            "toId": "toId",
            "time": date,
            "text": "text",
        ]
        let image = UIImage(named: "user")!
        let message = Message(dictionary: dictionary)
        viewModel = MessageViewModel(model: message, currentUserId: "fromId", userImage: image)
        XCTAssertEqual(viewModel.userMainImage, image)
        XCTAssertEqual(viewModel.text, "text")
    }
    
    func testImageMessageViewModel() {
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
        let image = UIImage(named: "user")!
        var message = Message(dictionary: dictionary)
        message.image = image
        viewModel = MessageViewModel(model: message, currentUserId: "fromId", userImage: image)
        XCTAssertEqual(viewModel.image, image)
        XCTAssertEqual(viewModel.userMainImage, image)
        XCTAssertEqual(viewModel.videoUrl, "videoUrl")
        XCTAssertEqual(viewModel.text, "")
    }
}
