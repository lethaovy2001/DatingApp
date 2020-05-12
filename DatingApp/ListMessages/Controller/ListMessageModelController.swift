//
//  ListMessageModelController.swift
//  DatingApp
//
//  Created by Vy Le on 5/11/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class ListMessageModelController {
    private var firebaseService = FirebaseService()
    private var users = [UserModel]()
    
    func getCurrentUserId() -> String? {
        return firebaseService.getUserID()
    }
    
    func getUsers() -> [UserModel] {
        return users
    }
    
    func getMessagesList(_ completion : @escaping()->()) {
        firebaseService.getListMessages({ matchedUsers in
            for userId in matchedUsers {
                var user: UserModel!
                self.firebaseService.getUserWithId(id: userId, { userInfo in
                    self.firebaseService.getMainUserImage(from: userId, { image in
                        if let image = image {
                            user = UserModel(info: userInfo, mainImage: image)
                        } else {
                            user = UserModel(info: userInfo)
                        }
                        self.users.append(user)
                        completion()
                    })
                })
            }
        })
    }
}
