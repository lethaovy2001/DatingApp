//
//  UserModelController.swift
//  DatingApp
//
//  Created by Vy Le on 4/8/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class UserDetailsViewModel {
    private var model: UserModel
    private let calendar: Calendar
    private let type: UserType
    
    enum UserType {
        case currentUser
        case otherUser
    }
    
    init(model: UserModel) {
        self.model = model
        self.calendar = Calendar(identifier: .gregorian)
        self.type = .currentUser
    }
    
    init(model: UserModel, type: UserType) {
        self.model = model
        self.calendar = Calendar(identifier: .gregorian)
        self.type = type
    }
}

extension UserDetailsViewModel {
    var name: String {
        return model.name ?? ""
    }
    
    var ageText: String {
        guard let date = model.birthday else { return "" }
        let today = calendar.startOfDay(for: Date())
        let birthday = calendar.startOfDay(for: date)
        let components = calendar.dateComponents([.year],
                                                 from: birthday,
                                                 to: today)
        let age = components.year!
        return "\(age)"
    }
    
    var work: String {
        return model.work ?? ""
    }
    
    var images: [UIImage] {
        return model.images ?? []
    }
    
    var bio: String {
        return model.bio ?? ""
    }
    
    var id: String? {
        return model.id ?? nil
    }
    
    var userType: UserType {
        return self.type
    }
}


