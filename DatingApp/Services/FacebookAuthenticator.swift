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
    private let permissions = [Constants.FacebookPermission.publicProfile]
    private let permission = Constants.FacebookPermission.publicProfile
    
    func loginPressed(viewController: UIViewController, _ completion: @escaping(Bool)->()) {
        let loginManager = LoginManager()
        if let grantedPermission = AccessToken.current?.hasGranted(permission: permission) {
            if grantedPermission {
                completion(true)
            } else {
                loginManager.logIn(permissions: permissions, from: viewController) { (result, error) in
                    if error != nil {
                        print("***** Error: \(error!)")
                    } else if result?.isCancelled == true {
                        print("***** Cancel")
                    } else {
                        completion(false)
                    }
                }
            }
        }
    }
    
    func getFBUserInfo(_ completion: @escaping(Any?)->()) {
        GraphRequest(graphPath: "/me", parameters: ["fields": "first_name"]).start { (connection, result, err) in
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




