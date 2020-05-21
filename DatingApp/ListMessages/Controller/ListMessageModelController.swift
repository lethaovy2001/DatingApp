//
//  ListMessageModelController.swift
//  DatingApp
//
//  Created by Vy Le on 5/11/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class ListMessageModelController {
    // MARK: Properties
    private var users = [UserModel]()
    private var messages = [Message]()
    private let database: Database
    
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
    
    func getMessages() -> [Message] {
        return messages
    }
    
    func getMessagesList(_ completion : @escaping()->()) {
        database.getListMessage() { users, messages in
            self.users = users
            self.messages = messages
            completion()
        }
    }
}
