//
//  UserModelController.swift
//  DatingApp
//
//  Created by Vy Le on 7/22/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class UserModelController {
    // MARK: - Properties
    private let database: Database
    private var user: UserModel?
    
    // MARK: - Initializer
    init(database: Database = FirebaseService.shared) {
        self.database = database
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadCurrentUserProfile(id: String, _ completion : @escaping()->()) {
        database.loadUserProfile(withId: id) { (user) in
            self.user = user
            completion()
        }
    }
}

extension UserModelController {
    var interestedInGender: Gender? {
        guard let genderString = user?.interestedIn,
            let gender = Gender(rawValue: genderString)
            else { return nil }
        return gender
    }
}

enum Gender: String {
    case male = "male"
    case female = "female"
}
