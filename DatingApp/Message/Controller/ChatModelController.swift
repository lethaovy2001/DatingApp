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
    
    func getCurrentUserId() -> String? {
        return firebaseService.getUserID()
    }
    
    func getMessages() -> [Message] {
        self.messages.sort( by: { (message1, message2) -> Bool in
            if let timeSent1 = message1.time, let timeSent2 = message2.time {
                return (timeSent1) < (timeSent2)
            }
            return false
        })
        return messages
    }
    
    func getCurrentUserId() -> String? {
        
        return firebaseService.getUserID()
    }
    
    func getMessagesFromDatabase(_ completion : @escaping()->()) {
        firebaseService.getMessages(toId: "2", { data in
            for messageId in data {
                self.firebaseService.getMessageDetails(with: messageId.key, { messageData in
                    guard let time = messageData["time"] as? Timestamp else { return }
                    let convertedTime = self.firebaseService.convertToDate(timestamp: time)
                    let message = Message(fromId: messageData["fromId"] as! String, toId: messageData["toId"] as! String, text: messageData["text"] as! String, time: convertedTime)
                    self.messages.append(message)
                    completion()
                })
            }
        })
    }
    
    func updateMessageToDatabase(message: [String: Any]) {
        let model = Message(dictionary: message)
        firebaseService.saveMessageToDatabase(with: model, { messageId in
            self.firebaseService.updateMessageReference(toId: "2", messageId: messageId)
        })
    }
}
