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
    var imageWidth: Int?
    var imageHeight: Int?
    var image: UIImage?

    init(dictionary: [String: Any]) {
        self.fromId = dictionary["fromId"] as? String
        self.text = dictionary["text"] as? String
        self.toId = dictionary["toId"] as? String
        self.time = dictionary["time"] as? Date
    }
    
    init(dictionary: [String: Any], image: UIImage) {
        self.fromId = dictionary["fromId"] as? String
        self.toId = dictionary["toId"] as? String
        self.time = dictionary["time"] as? Date
        self.image = image
        self.imageUrl = dictionary["imageUrl"] as? String
        self.imageWidth = dictionary["imageWidth"] as? Int
        self.imageHeight = dictionary["imageHeight"] as? Int
    }
    
    
}

