//
//  ListMessageViewModel.swift
//  DatingApp
//
//  Created by Vy Le on 5/11/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class ListMessageViewModel {
    private var listMessageModel: ListMessageModel
    
    init(listMessageModel: ListMessageModel) {
        self.listMessageModel = listMessageModel
    }
}

extension ListMessageViewModel {
    var userName: String {
        return listMessageModel.user.name ?? "N/A"
    }
    
    var userImage: UIImage {
        return listMessageModel.user.mainImage ?? UIImage(systemName: "person.fill")!
    }
    
    var latestMessage: String {
        if let text = listMessageModel.message.text {
            return text
        } else if listMessageModel.message.videoUrl != nil {
            return "Share a video"
        } else if listMessageModel.message.imageUrl != nil {
            return "Share an image"
        } else {
            return "You have a new match!"
        }
    }
    
    var messageStyle: UIFont {
        if listMessageModel.message.text == nil {
            return UIFont.italicSystemFont(ofSize: 18)
        } else {
            return UIFont.systemFont(ofSize: 18)
        }
    }
}

extension ListMessageViewModel {
    func configure(_ view: ListMessageCell) {
        view.nameLabel.text = userName
        view.profileImageView.image = userImage
        view.chatLabel.text = latestMessage
        view.chatLabel.font = messageStyle
    }
}
