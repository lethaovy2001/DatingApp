//
//  CreateUserOperation.swift
//  DatingApp
//
//  Created by Vy Le on 7/20/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import Firebase

final class CreateUserOperation: AsyncResultOperation<AuthDataResult, Error> {
    // MARK: - Properties
    private let auth: Authentication
    private let email: String
    private let password: String
    
    init(auth: Authentication = FirebaseService.shared,
         email: String,
         password: String) {
        self.auth = auth
        self.email = email
        self.password = password
    }
    
    override func main() {
        guard !dependencies.contains(where: { $0.isCancelled }), !isCancelled else {
            return
        }
        auth.createUser(email: email, password: password) { result in
            switch result {
            case .success(let data):
                self.finish(with: .success(data))
            case .failure(let error):
                self.finish(with: .failure(error))
            }
        }
    }
}
