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
    enum RelationshipType {
        case currentUser
        case otherPerson
    }
    
    enum MessageType {
        case text
        case image
    }
    
    var text: String {
        return model.text ?? ""
    }
    
    var image: UIImage? {
        return model.image ?? nil
    }
    
    var videoUrl: String? {
        return model.videoUrl
    }
    
    var style: RelationshipType {
        if model.fromId == currentUserId {
            return RelationshipType.currentUser
        } else {
            return RelationshipType.otherPerson
        }
    }
    
    var messageType: MessageType {
        if model.text != nil {
            return MessageType.text
        } else {
            return MessageType.image
        }
    }
}
