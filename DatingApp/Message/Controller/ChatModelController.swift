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
    var user: UserModel?
    
    enum LoadMessagesState {
        case success
        case noMessage
    }
    
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
    
    func getMessagesFromDatabase(_ completion : @escaping(LoadMessagesState)->()) {
        guard let toId = user?.id else { return }
        var totalMessages = 0
        var currentMessageIndex = 0
        firebaseService.getMessages(toId: toId, { data in
            if data.isEmpty {
                completion(.noMessage)
            }
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
                            currentMessageIndex += 1
                            if (currentMessageIndex == totalMessages) {
                                completion(.success)
                            }
                        })
                    } else {
                        message = Message(dictionary: values)
                        self.messages.append(message)
                        currentMessageIndex += 1
                        if (currentMessageIndex == totalMessages) {
                            completion(.success)
                        }
                    }
                })
            }
            totalMessages += 1
        })
    }
    
    func updateMessageToDatabase(message: [String: Any]) {
        let model = Message(dictionary: message)
        if let toId = model.toId {
            firebaseService.saveMessageToDatabase(with: model, { messageId in
                self.firebaseService.updateMessageReference(toId: toId, messageId: messageId)
            })
        }
    }
}
