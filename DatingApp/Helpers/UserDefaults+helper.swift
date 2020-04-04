//
//  UserDefaults.swift
//  DatingApp
//
//  Created by Vy Le on 4/3/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import Foundation

extension UserDefaults {
    enum UserDefaultsKeys: String {
        case isLoggedIn
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    
    }
    
    func setIsLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
}
