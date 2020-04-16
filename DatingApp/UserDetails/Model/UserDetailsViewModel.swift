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
    
    init(model: UserModel) {
        self.model = model
    }
}

extension UserDetailsViewModel {
    var name: String {
        return model.name
    }
    
    var age: Int {
        return model.age ?? 0
    }
    
    var work: String {
        return model.work ?? "Unknown workplace"
    }
    
    var mainImageName: String {
        return model.mainImageName ?? ""
    }
    
    var images: [String] {
        return model.imageNames ?? [""]
    }
    
    var bio: String {
        return model.bio ?? "No bio"
    }
}
