//
//  Message.swift
//  DatingApp
//
//  Created by Vy Le on 4/24/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

struct Message {
    var fromId: String
    var toId: String
    var text: String
    var time: Date
    
    init(fromId: String, toId: String, text: String, time: Date) {
        self.fromId = fromId
        self.toId = toId
        self.text = text
        self.time = time
    }
}

