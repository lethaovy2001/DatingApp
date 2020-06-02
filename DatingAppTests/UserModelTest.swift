//
//  UserModelTest.swift
//  DatingAppTests
//
//  Created by Vy Le on 5/18/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import XCTest
@testable import DatingApp

class UserModelTest: XCTestCase {
    
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
    
    func testModelInfo() {
        let date = Date()
        let info: [String: Any] = [
            "id": "Id",
            "first_name": "First Name",
            "birthday": date,
            "work": "Work",
            "bio": "Bio",
            "gender": "Gender"
        ]
        let model = UserModel(info: info)
        XCTAssertEqual(model.id, "Id")
        XCTAssertEqual(model.name, "First Name")
        XCTAssertEqual(model.birthday, date)
        XCTAssertEqual(model.work, "Work")
        XCTAssertEqual(model.bio, "Bio")
        XCTAssertEqual(model.gender, "Gender")
    }
    
    func testModelInfoWithMainImage() {
        let info: [String: Any] = [:]
        let image = UIImage(named: "Vy")!
        let model = UserModel(info: info, mainImage: image)
        XCTAssertEqual(model.mainImage, image)
    }
    
    func testModelInfoWithImages() {
        let info: [String: Any] = [:]
        let image = UIImage(named: "Vy")!
        let images = [image, image]
        let model = UserModel(info: info, images: images)
        XCTAssertEqual(model.images, images)
    }
}
