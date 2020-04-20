//
//  FacebookAuthenticator.swift
//  DatingApp
//
//  Created by Vy Le on 4/12/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class FacebookAuthenticator {
    private let viewController: UIViewController
    private let modelController = MainModelController()
    private var firebaseService: FirebaseService!
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func loginPressed(_ completion : @escaping()->()) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email", "user_birthday, user_gender"], from: viewController) { (result, error) in
            if error != nil {
                print("***** Error: \(error!)")
            } else if result?.isCancelled == true {
                print("***** Cancel")
            } else {
                print("Log in with fb")
                UserDefaults.standard.setIsLoggedIn(value: true)
                UserDefaults.standard.synchronize()
                completion()
            }
        }
    }
    
    func getFBUserInfo(_ completion: @escaping(Any?)->()) {
        GraphRequest(graphPath: "/me", parameters: ["fields": "first_name, birthday, gender"]).start { (connection, result, err) in
            if err != nil {
                print("Failed to start graph request:", err!)
                return
            }
            completion(result)
        }
    }
    
    func getFBAccessToken() -> String {
        return AccessToken.current!.tokenString
    }
}


