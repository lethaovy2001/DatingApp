//
//  Authentication.swift
//  DatingApp
//
//  Created by Vy Le on 5/18/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import Firebase

protocol Authentication {
    func getCurrentUserId() -> String?
    func createUser(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void)
    func logUserIn(withEmail email: String, password: String, completion: @escaping(String?)->())
    func logUserIn(withCredential credential: String, completion: @escaping(String?)->())
    func logout()
}
