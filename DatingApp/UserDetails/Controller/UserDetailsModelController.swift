//
//  UserDetailsModelController.swift
//  DatingApp
//
//  Created by Vy Le on 5/12/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class UserDetailsModelController {
    // MARK: - Properties
    private var firebaseService = FirebaseService()
    private var user = UserModel(info: ["":""])
    private let database: Database
    
    // MARK: - Initializer
    init(database: Database) {
        self.database = database
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Getters
    func getCurrentUserId() -> String? {
        return firebaseService.getUserID() ?? nil
    }
    
    func getUserInfo() -> UserModel {
        return user
    }
    
    func getData(id: String?,_ completion : @escaping()->()) {
        if let id = id {
            database.loadUserProfile(withId: id) { user in
                self.user = user
                completion()
            }
        }
    }
}
