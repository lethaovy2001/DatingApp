//
//  UserModel.swift
//  DatingApp
//
//  Created by Vy Le on 4/8/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

struct UserModel {
    let name: String
    let birthday: Date
    let work: String
    let bio: String
    let gender: String
    let images: [UIImage]
    
    init(name: String, birthday: Date, work: String, bio: String, gender: String, images: [UIImage]) {
        self.name = name
        self.birthday = birthday
        self.work = work
        self.bio = bio
        self.gender = gender
        self.images = images
    }
}
