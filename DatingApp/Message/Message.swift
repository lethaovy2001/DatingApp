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
    
    init(fromId: String, toId: String, text: String, time: Date) {
        self.fromId = fromId
        self.toId = toId
        self.text = text
        self.time = time
    }
    
    init(dictionary: [String: Any]) {
        self.fromId = dictionary["fromId"] as? String
        self.text = dictionary["text"] as? String
        self.toId = dictionary["toId"] as? String
        self.time = dictionary["time"] as? Date
    }
    
    func getTextMessageDictionary() -> [String: Any] {
        let dictionary: [String: Any] = [
            "fromId": fromId ?? "",
            "toId": toId ?? "",
            "text": text ?? "",
            "time": time ?? Date(),
        ]
        return dictionary
    }
}

