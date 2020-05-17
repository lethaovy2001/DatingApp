//
//  UserDatabase.swift
//  DatingApp
//
//  Created by Vy Le on 5/16/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

protocol WritableDatabase: Database {
    func updateUser(info: [String: Any])
    func updateUserImages(images: [UIImage])
}

extension WritableDatabase {
    func updateUser(info: [String: Any]) {
        firebaseService.updateDatabase(with: info)
    }
    
    func updateUserImages(images: [UIImage]) {
        firebaseService.uploadImages(images: images) {
            
        }
    }
}



