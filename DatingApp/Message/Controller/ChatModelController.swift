//
//  ChatModelController.swift
//  DatingApp
//
//  Created by Vy Le on 4/25/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class ChatModelController {
    //MARK: - Properties
    private var messages = [Message]()
    private var database: Database
    var user: UserModel?
    
    //MARK: - Initializer
    init(database: Database) {
        self.database = database
    }
    
    //MARK: - Getters
    func getMessages() -> [Message] {
        self.messages.sort( by: { (message1, message2) -> Bool in
            if let timeSent1 = message1.time, let timeSent2 = message2.time {
                return (timeSent1) < (timeSent2)
            }
            return false
        })
        return messages
    }
    
    //MARK: - Load data
    func getMessagesFromDatabase(_ completion : @escaping()->()) {
        guard let id = user?.id else { return }
        database.loadMessages(withId: id) { messages in
            self.messages = messages
            completion()
        }
    }
}
