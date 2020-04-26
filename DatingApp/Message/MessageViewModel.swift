//
//  MessageViewModel.swift
//  DatingApp
//
//  Created by Vy Le on 4/25/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class MessageViewModel {
    private var model: Message
    private let calendar: Calendar
    private var currentUserId: String
    
    init(model: Message, currentUserId: String) {
        self.model = model
        self.currentUserId = currentUserId
        self.calendar = Calendar(identifier: .gregorian)
    }
}

extension MessageViewModel {
    enum MessageType {
        case currentUser
        case otherPerson
    }
    
    var text: String {
        return model.text
    }
    
    var style: MessageType {
        if model.fromId == currentUserId {
            return MessageType.currentUser
        } else {
            return MessageType.otherPerson
        }
    }
}
