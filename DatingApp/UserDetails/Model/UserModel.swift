//
//  UserModel.swift
//  DatingApp
//
//  Created by Vy Le on 4/8/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

struct UserModel: Encodable {
    let name: String
    let birthday: Date
    let work: String
    let bio: String
    let gender: String
//    let imageNames : [String]
//    let mainImageName: String
    
    enum CodingKeys: String, CodingKey {
        case name = "first_name"
        case birthday
        case work
        case bio
        case gender
//        case imageNames
//        case mainImageName
    }
    
    init(name: String, birthday: Date, work: String, bio: String, gender: String) {
        self.name = name
        self.birthday = birthday
        self.work = work
        self.bio = bio
        self.gender = gender
    }
    
    init(info: [String: Any], birthday: Date) {
        self.name = info["first_name"] as! String
        self.birthday = birthday
        self.work = info["work"] as! String
        self.bio = info["bio"] as! String
        self.gender = info["gender"] as! String
    }
}
