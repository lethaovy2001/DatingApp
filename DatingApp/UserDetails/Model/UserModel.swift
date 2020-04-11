//
//  UserModel.swift
//  DatingApp
//
//  Created by Vy Le on 4/8/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

struct UserModel {
    var name: String
    var age: Int
    var work: String
    var bio: String
    var imageNames : [String]
    var mainImageName: String
     
    init(name: String, age: Int, imageNames: [String], mainImageName: String, work: String, bio: String) {
        self.name = name
        self.age = age
        self.imageNames = imageNames
        self.mainImageName = mainImageName
        self.work = work
        self.bio = bio
    }
}
