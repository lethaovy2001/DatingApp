//
//  ChatViewModel.swift
//  DatingApp
//
//  Created by Vy Le on 5/11/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class ChatViewModel {
    private var userModel: UserModel
    private var currentUserId: String
    
    init(userModel: UserModel, currentUserId: String) {
        self.userModel = userModel
        self.currentUserId = currentUserId
    }
}

extension ChatViewModel {
    var userName: String {
        return userModel.name ?? "N/A"
    }
    
    var userImage: UIImage {
        return userModel.mainImage ?? UIImage(systemName: "person.fill")!
    }
}
