//
//  ChatModelController.swift
//  DatingApp
//
//  Created by Vy Le on 4/25/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import Firebase

class ChatModelController {
    private var firebaseService = FirebaseService()
    private var messages = [Message]()
    
    func getMessages() -> [Message] {
        return messages
    }
    
    func getMessagesFromDatabase(_ completion : @escaping()->()) {
        firebaseService.getMessages(toId: "2", { data in
            for messageId in data {
                self.firebaseService.getMessageDetails(with: messageId.key, { messageData in
                    if let birthday = messageData["time"] as? Timestamp {
                        let date = self.firebaseService.convertToDate(timestamp: birthday)
                        let message = Message(fromId: messageData["fromId"] as! String, toId: messageData["toId"] as! String, text: messageData["text"] as! String, time: date as! Date)
                        self.messages.append(message)
                        completion()
                    }
                })
            }
        })
    }
    
    func updateMessageToDatabase(message: [String: Any]) {
        firebaseService.saveMessageToDatabase(with: message, { messageId in
            self.firebaseService.updateMessageReference(toId: "2", messageId: messageId)
        })
    }
}
