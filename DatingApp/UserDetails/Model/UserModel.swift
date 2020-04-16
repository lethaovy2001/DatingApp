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
    let age: Int?
    let work: String?
    let bio: String?
    let imageNames : [String]?
    let mainImageName: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "first_name"
        case age
        case work
        case bio
        case imageNames
        case mainImageName
    }
     
    init(name: String, age: Int?, imageNames: [String]?, mainImageName: String?, work: String?, bio: String?) {
        self.name = name
        self.age = age
        self.imageNames = imageNames
        self.mainImageName = mainImageName
        self.work = work
        self.bio = bio
    }
}
