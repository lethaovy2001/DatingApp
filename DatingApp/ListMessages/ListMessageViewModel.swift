//
//  ListMessageViewModel.swift
//  DatingApp
//
//  Created by Vy Le on 5/11/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class ListMessageViewModel {
    private var userModel: UserModel
    private var message: Message?
    private var currentUserId: String
    
    init(userModel: UserModel, message: Message, currentUserId: String) {
        self.userModel = userModel
        self.currentUserId = currentUserId
        self.message = message
    }
    
    init(userModel: UserModel, currentUserId: String) {
        self.userModel = userModel
        self.currentUserId = currentUserId
    }
}

extension ListMessageViewModel {
    var userName: String {
        return userModel.name ?? "N/A"
    }
    
    var userImage: UIImage {
        return userModel.mainImage ?? UIImage(systemName: "person.fill")!
    }
    
    var latestMessage: String {
        if let text = message?.text {
            return text
        } else if message?.videoUrl != nil {
            return "Share a video"
        } else if message?.imageUrl != nil {
            return "Share an image"
        } else {
            return "You have a new match!"
        }
    }
    
    var messageStyle: UIFont {
        if message?.text == nil {
            return UIFont.italicSystemFont(ofSize: 18)
        } else {
            return UIFont.systemFont(ofSize: 18)
        }
    }
    
}
