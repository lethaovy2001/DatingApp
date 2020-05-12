//
//  UserDetailsModelController.swift
//  DatingApp
//
//  Created by Vy Le on 5/12/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class UserDetailsModelController {
    private var firebaseService = FirebaseService()
    private var user = UserModel(info: ["":""])
    
    func getCurrentUserId() -> String? {
        return firebaseService.getUserID() ?? nil
    }
    
    func getUserInfo() -> UserModel {
        return user
    }
    
    func getData(id: String?,_ completion : @escaping()->()) {
        if let id = id {
            firebaseService.getUserWithId(id: id, { user in
                self.firebaseService.getUserImagesFromDatabase(from: id, { images in
                    self.user = UserModel(info: user, images: images)
                    completion()
                })
            })
        }
    }
}
