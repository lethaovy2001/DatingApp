//
//  UserViewModelTest.swift
//  DatingAppTests
//
//  Created by Vy Le on 5/18/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import XCTest
@testable import DatingApp

class UserViewModelTest: XCTestCase {
    
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
    
    func testViewModel() {
        let info: [String: Any] = [
            "id": "Id",
            "first_name": "First Name",
            "birthday": Date(),
            "work": "Work",
            "bio": "Bio",
        ]
        let image = UIImage(named: "Vy")!
        let images = [image, image]
        let model = UserModel(info: info, images: images)
        let viewModel = UserDetailsViewModel(model: model)
        XCTAssertEqual(viewModel.id, "Id")
        XCTAssertEqual(viewModel.name, "First Name")
        XCTAssertEqual(viewModel.ageText, "0")
        XCTAssertEqual(viewModel.bio, "Bio")
        XCTAssertEqual(viewModel.work, "Work")
        XCTAssertEqual(viewModel.images, images)
    }
    
    func testNilViewModel() {
        let info: [String: Any?] = [
            "id": nil,
            "first_name": nil,
            "birthday": nil,
            "work": nil,
            "bio": nil,
        ]
        let model = UserModel(info: info)
        let viewModel = UserDetailsViewModel(model: model)
        XCTAssertEqual(viewModel.id, nil)
        XCTAssertEqual(viewModel.name, "")
        XCTAssertEqual(viewModel.ageText, "")
        XCTAssertEqual(viewModel.bio, "")
        XCTAssertEqual(viewModel.work, "")
        XCTAssertEqual(viewModel.images, [])
    }
}
