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
    private let calendar: Calendar
    
    init(model: Message) {
        self.model = model
        self.calendar = Calendar(identifier: .gregorian)
    }
}

extension MessageViewModel {
    var text: String {
        return model.text ?? ""
    }
}
