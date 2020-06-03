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
    var work: String?
    var bio: String?
    var gender: String?
    var images: [UIImage]?
    var mainImage: UIImage?
    var id: String?
    var interestedIn: String?
    
    init(info: [String: Any]) {
        self.id = info["id"] as? String
        self.name = info["first_name"] as? String
        self.work = info["work"] as? String
        self.bio = info["bio"] as? String
        self.gender = info["gender"] as? String
        self.images = info["images"] as? [UIImage]
        mainImage = images?.first
        self.interestedIn = info["interestedIn"] as? String
        if let birthday = info["birthday"] as? Timestamp {
            self.birthday = birthday.dateValue()
        } else {
            self.birthday = info["birthday"] as? Date
        }
    }
    
    func getUserInfo() -> [String: Any]? {
        guard
            let id = id,
            let name = name,
            let gender = gender,
            let interestedIn = interestedIn,
            let birthday = birthday,
            let bio = bio,
            let work = work
        else { return nil }
        let dictionary: [String: Any] = [
            "id": id,
            "first_name": name,
            "gender": gender,
            "interestedIn": interestedIn,
            "birthday": birthday,
            "bio": bio,
            "work": work
        ]
        return dictionary
    }
}
