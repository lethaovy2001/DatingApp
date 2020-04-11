//
//  UserModel.swift
//  DatingApp
//
//  Created by Vy Le on 4/10/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

struct User: Codable {
    var name: String
    var age: Int
}

extension User {
    struct CodingData: Codable {
        struct Container: Codable {
            var fullName: String
            var userAge: Int
        }

        var userData: Container
    }
}

extension User.CodingData {
    var user: User {
        return User(
            name: userData.fullName,
            age: userData.userAge
        )
    }
}
