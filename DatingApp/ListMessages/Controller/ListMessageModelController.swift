//
//  ListMessageModelController.swift
//  DatingApp
//
//  Created by Vy Le on 5/11/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class ListMessageModelController {
    private var firebaseService = FirebaseService.shared
    private var users = [UserModel]()
    
    func getUsers() -> [UserModel] {
        return users
    }
    
    func getMessagesList(_ completion : @escaping()->()) {
        firebaseService.getListMessages({ matchedUsers in
            for userId in matchedUsers {
                self.firebaseService.getUserWithId(id: userId, { userInfo in
                    var user = UserModel(info: userInfo)
                    self.firebaseService.getMainUserImage(from: userId, { image in
                        if let image = image {
                            user.mainImage = image
                        }
                        self.users.append(user)
                        completion()
                    })
                })
            }
        })
    }
}
