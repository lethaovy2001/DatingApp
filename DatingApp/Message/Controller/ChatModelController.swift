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
        self.messages.sort( by: { (message1, message2) -> Bool in
            if let time1 = message1.time, let time2 = message2.time {
                return (time1) < (time2)
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
                    var values = messageData
                    values.updateValue(convertedTime, forKey: "time")
                    var message: Message!
                    if let imageUrl = values["imageUrl"] as? String {
                        self.firebaseService.downloadImageFromStorage(url: imageUrl, { image in
                            message = Message(dictionary: values, image: image)
                            self.messages.append(message)
                            completion()
                        })
                    } else {
                        message = Message(dictionary: values)
                        self.messages.append(message)
                        completion()
                    }
                })
            }
        })
    }
    
    func updateMessageToDatabase(message: [String: Any]) {
        firebaseService.saveMessageToDatabase(with: message, { messageId in
            //TODO: remove mock id
            self.firebaseService.updateMessageReference(toId: "2", messageId: messageId)
        })
    }
}
