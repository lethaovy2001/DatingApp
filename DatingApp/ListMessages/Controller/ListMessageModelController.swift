//
//  ListMessageModelController.swift
//  DatingApp
//
//  Created by Vy Le on 5/11/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import Firebase

class ListMessageModelController {
    private var firebaseService = FirebaseService()
    private var users = [UserModel]()
    private var messages = [Message]()
    
    func getCurrentUserId() -> String? {
        return firebaseService.getUserID()
    }
    
    func getUsers() -> [UserModel] {
        return users
    }
    
    func getMessages() -> [Message] {
        return messages
    }
    
    func getMessagesList(_ completion : @escaping()->()) {
        firebaseService.getListMessages({ matchedUsers in
            var recipientIndex = 0
            for userId in matchedUsers {
                var user: UserModel!
                self.firebaseService.getUserWithId(id: userId, { userInfo in
                    self.firebaseService.getMainUserImage(from: userId, { image in
                        if let image = image {
                            user = UserModel(info: userInfo, mainImage: image)
                        } else {
                            user = UserModel(info: userInfo)
                        }
                        self.users.append(user)
                        let message = Message(dictionary: [:])
                        self.messages.append(message)
                        recipientIndex += 1
                        self.firebaseService.getLastestMessage(toId: userId, { messageId, message in
                        switch message {
                            case .noMessage:
                                completion()
                                return
                            case .hasMessage:
                                self.getMessageDetail(userId: userId, messageId: messageId, recipientIndex: recipientIndex, totalRecipient: matchedUsers.count, {
                                    completion()
                                })
                            }
                        })
                    })
                })
            }
        })
    }
    
    func getMessageDetail(userId: String, messageId: String, recipientIndex: Int, totalRecipient: Int,_ completion : @escaping()->()) {
        self.firebaseService.getMessageDetails(with: messageId, { messageData in
            guard let time = messageData["time"] as? Timestamp else { return }
            let convertedTime = self.firebaseService.convertToDate(timestamp: time)
            var values = messageData
            values.updateValue(convertedTime, forKey: "time")
            let message = Message(dictionary: values)
            var index = 0
            for person in self.users {
                if person.id == userId {
                    self.messages.remove(at: index)
                    self.messages.insert(message, at: index)
                    completion()
                }
                index += 1
            }
        })
    }
}
