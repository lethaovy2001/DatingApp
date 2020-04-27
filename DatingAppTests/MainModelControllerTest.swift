//
//  MainModelControllerTest.swift
//  DatingAppTests
//
//  Created by Vy Le on 4/27/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import XCTest
@testable import DatingApp

class MainModelControllerTest: XCTestCase {
    
    private var users = [UserModel]()
    private var user: UserModel!
    
    override func setUp() {
        let user1 = UserModel(name: "user1", birthday: Date(), work: "work1", bio: "bio1", gender: "female", images: [UIImage()])
        let user2 = UserModel(name: "user2", birthday: Date(), work: "work2", bio: "bio2", gender: "male", images: [UIImage()])
        self.users.append(user1)
        self.users.append(user2)
    }
    
    func testGetUsers() {
        XCTAssertEqual(self.users[0].name, "user1")
        XCTAssertEqual(self.users[1].name, "user2")
        XCTAssertEqual(self.users.count, 2)
    }
    
    
}
