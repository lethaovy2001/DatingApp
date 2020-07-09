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
    func saveLikeUser(withId id: String)
    func saveDislikeUser(withId id: String)
    func saveMessage(message: Message)
    func uploadUserImages(images: [UIImage], _ completion: @escaping(UIState)->())
    func uploadImageMessage(message: Message)
    func uploadVideoMessage(url: URL, message: Message)
    func updateListOfUsers()
    func loadUserProfile(withId id: String,_ completion: @escaping(UserModel)->())
    func loadAllUsers(_ completion: @escaping([UserModel])->())
    func loadListMessages(_ completion: @escaping([ListMessageModel])->())
    func loadMessages(withId id: String,_ completion: @escaping([Message])->())
}


