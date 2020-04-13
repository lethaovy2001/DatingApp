//
//  UserModelController.swift
//  DatingApp
//
//  Created by Vy Le on 4/8/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class UserDetailsViewModel {
    private let model: UserModel
    
    init(model: UserModel) {
        self.model = model
    }
    
    var name: String {
        return model.name
    }
    
    var age: Int {
        return model.age
    }
    
    var work: String {
        return model.work
    }
    
    var mainImageName: String {
        return model.mainImageName
    }
    
    var images: [String] {
        return model.imageNames
    }
    
    var bio: String {
        return model.bio
    }
}

extension UserDetailsViewModel {
    typealias Changes = (name: String, age: Int, imageNames: [String], mainImageName: String, work: String, bio: String)

    func update(with changes: Changes) {
        // Apply changes
        var updatedModel = model
        updatedModel.name = changes.name
        updatedModel.age = changes.age
        updatedModel.imageNames = changes.imageNames
        updatedModel.mainImageName = changes.mainImageName
        updatedModel.work = changes.work
        
        
    }
}
