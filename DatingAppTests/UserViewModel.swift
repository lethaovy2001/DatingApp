//
//  UserViewModel.swift
//  DatingAppTests
//
//  Created by Vy Le on 4/27/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import XCTest
@testable import DatingApp

class UserViewModel: XCTestCase {
    
    func testViewModel() {
        let model = UserModel(name: "Vy", birthday: Date(), work: "UW Hospital", bio: "Sweet but psycho", gender: "female", images: [UIImage(named: "Vy.jpg")!])
        let userViewModel = UserDetailsViewModel(model: model)
        
        XCTAssertEqual(userViewModel.name, "Vy")
        XCTAssertEqual(userViewModel.ageText, "0")
        XCTAssertEqual(userViewModel.work, "UW Hospital")
        XCTAssertEqual(userViewModel.bio, "Sweet but psycho")
        XCTAssertEqual(userViewModel.images, [UIImage(named: "Vy.jpg")!])
    }

}
