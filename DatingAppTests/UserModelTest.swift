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
    private var model: UserModel!
    private var date: Date!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        date = Date()
        let info: [String: Any] = [
            "id": "Id",
            "first_name": "First Name",
            "birthday": date!,
            "work": "Work",
            "bio": "Bio",
            "gender": "Gender",
            "interestedIn": "InterestedIn"
        ]
        model = UserModel(info: info)
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
        XCTAssertEqual(model.id, "Id")
        XCTAssertEqual(model.name, "First Name")
        XCTAssertEqual(model.birthday, date)
        XCTAssertEqual(model.work, "Work")
        XCTAssertEqual(model.bio, "Bio")
        XCTAssertEqual(model.gender, "Gender")
    }
    
    func testGetUserInfo() {
        let dictionary = model.getUserInfo()!
        XCTAssertEqual(dictionary["id"] as! String, "Id")
        XCTAssertEqual(dictionary["first_name"] as! String, "First Name")
        XCTAssertEqual(dictionary["birthday"] as! Date, date)
        XCTAssertEqual(dictionary["work"] as! String, "Work")
        XCTAssertEqual(dictionary["bio"] as! String, "Bio")
        XCTAssertEqual(dictionary["gender"] as! String, "Gender")
        XCTAssertEqual(dictionary["interestedIn"] as! String, "InterestedIn")
    }
}
