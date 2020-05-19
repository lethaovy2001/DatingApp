//
//  Authentication.swift
//  DatingApp
//
//  Created by Vy Le on 5/18/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

protocol Authentication {
    func getCurrentUserId() -> String?
    func createUser(email: String, password: String, name: String, completion: @escaping(String?)->())
    func logUserIn(withEmail email: String, password: String, completion: @escaping(String?)->())
    func logout()
}
