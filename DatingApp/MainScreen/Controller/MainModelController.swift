//
//  MainModelController.swift
//  DatingApp
//
//  Created by Duy Le on 4/4/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import Foundation

class MainModelController {
    // MARK: - Properties
    private var users = [UserModel]()
    private var user = UserModel(info: ["":""])
    private var converter = DateConverter()
    private var database: Database
    
    // MARK: - Initializer
    init(database: Database) {
        self.database = database
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Getters
    func getUsers() -> [UserModel] {
        return users
    }
    
    func getUserInfo() -> UserModel {
        return user
    }
    
    // MARK: - Load data
    func getAllUsers(_ completion : @escaping()->()){
        database.loadAllUsers() { users in
            for user in users {
                guard let id = user.id else { return }
                self.database.loadUserImages(withId: id) { images in
                    var userModel = user
                    userModel.images = images
                    self.users.append(userModel)
                    completion()
                }
            }
        }
    }
}
