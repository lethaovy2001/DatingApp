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
    private var currentUserId: String
    private var userImage: UIImage?
    
    init(model: Message, currentUserId: String) {
        self.model = model
        self.currentUserId = currentUserId
    }
    
    init(model: Message, currentUserId: String, userImage: UIImage) {
        self.model = model
        self.currentUserId = currentUserId
        self.userImage = userImage
    }
}

extension MessageViewModel {
    var userMainImage: UIImage {
        return self.userImage ?? UIImage(systemName: "person.fill")!
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

extension MessageViewModel {
    func configure(_ view: ChatCell) {
        view.profileImageView.setImage(image: userMainImage)
        view.textView.text = text
        view.setUpMessageRelationshipStyle(style: style)
        view.setUpMessageType(messageType: messageType)
        view.containerViewWidthAnchor.constant =
            view.textView.estimatedFrameForText(text: text).width + 36
        if let image = image {
            view.messageImageView.setImage(image: image)
        }
        view.playButton.isHidden = videoUrl == nil
    }
}

enum RelationshipType {
    case currentUser
    case otherPerson
}

enum MessageType {
    case text
    case image
}
