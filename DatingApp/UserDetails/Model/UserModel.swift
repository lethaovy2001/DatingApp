//
//  UserModel.swift
//  DatingApp
//
//  Created by Vy Le on 4/8/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import Firebase

struct UserModel {
    let name: String?
    var birthday: Date?
    let work: String?
    let bio: String?
    let gender: String?
    let images: [UIImage]?
    
    init(info: [String: Any]) {
        self.name = info["first_name"] as? String
        self.work = info["work"] as? String
        self.bio = info["bio"] as? String
        self.gender = info["gender"] as? String
        self.images = info["images"] as? [UIImage]
        if let birthday = info["birthday"] as? Timestamp {
            self.birthday = birthday.dateValue()
        } else {
            self.birthday = info["birthday"] as? Date
        }
    }
}
