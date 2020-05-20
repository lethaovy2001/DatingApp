//
//  Database.swift
//  DatingApp
//
//  Created by Vy Le on 5/16/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

protocol Database {
    func saveProfile(ofUser user: UserModel)
    func updateListOfUsers()
    func loadAllUsers(_ completion: @escaping([UserModel])->())
    func loadUserImages(withId id: String,_ completion: @escaping([UIImage])->())
    func saveLikeUser(withId id: String)
    func saveDislikeUser(withId id: String)
}







