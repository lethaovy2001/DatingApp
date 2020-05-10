//
//  Message.swift
//  DatingApp
//
//  Created by Vy Le on 4/24/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

struct Message {
    var fromId: String?
    var toId: String?
    var text: String?
    var time: Date?
    var imageUrl: String?
    var imageWidth: CGFloat?
    var imageHeight: CGFloat?
    var image: UIImage?
    var videoUrl: String?
    
    init(dictionary: [String: Any]) {
        self.fromId = dictionary["fromId"] as? String
        self.text = dictionary["text"] as? String
        self.toId = dictionary["toId"] as? String
        self.time = dictionary["time"] as? Date
        self.imageUrl = dictionary["imageUrl"] as? String
        self.imageWidth = dictionary["imageWidth"] as? CGFloat
        self.imageHeight = dictionary["imageHeight"] as? CGFloat
        self.videoUrl = dictionary["videoUrl"] as? String
    }
    
    init(dictionary: [String: Any], image: UIImage) {
        self.fromId = dictionary["fromId"] as? String
        self.toId = dictionary["toId"] as? String
        self.time = dictionary["time"] as? Date
        self.image = image
        self.imageUrl = dictionary["imageUrl"] as? String
        self.imageWidth = dictionary["imageWidth"] as? CGFloat
        self.imageHeight = dictionary["imageHeight"] as? CGFloat
        self.videoUrl = dictionary["videoUrl"] as? String
    }
    
    func getTextMessageDictionary() -> [String: Any] {
        let dictionary: [String: Any] = [
            "fromId": fromId ?? "",
            "toId": toId ?? "",
            "text": text ?? "",
            "time": time ?? Date()
        ]
        return dictionary
    }
    
    func getImageMessageDictionary() -> [String: Any] {
        let dictionary: [String: Any] = [
            "fromId": fromId ?? "",
            "toId": toId ?? "",
            "time": time ?? Date(),
            "imageUrl": imageUrl ?? "",
            "imageWidth": imageWidth ?? 0,
            "imageHeight": imageHeight ?? 0,
            "videoUrl": videoUrl ?? ""
        ]
        return dictionary
    }
    
    func getMessageDictionary() -> [String: Any] {
        let dictionary: [String: Any] = [
            "fromId": fromId ?? "",
            "toId": toId ?? "",
            "text": text ?? "",
            "time": time ?? Date(),
            "imageUrl": imageUrl ?? "",
            "imageWidth": imageWidth ?? 0,
            "imageHeight": imageHeight ?? 0,
            "videoUrl": videoUrl ?? "",
        ]
        return dictionary
    }
    
    
}

