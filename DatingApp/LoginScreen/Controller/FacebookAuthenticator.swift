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
    var facebookUserDataDelegate: FacebookUserDataDelegate?
    private let modelController = MainModelController()
    
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
    
    private func calculateAge(birthday: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        guard let date = dateFormatter.date(from: birthday) else { return 0 }
        let now = Date()
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: date, to: now)
        let age = ageComponents.year!
        return age
    }
    
    func getFBUserInfo() {
        GraphRequest(graphPath: "/me", parameters: ["fields": "first_name, birthday, gender"]).start { (connection, result, err) in
            if err != nil {
                print("Failed to start graph request:", err!)
                return
            }
            let fbDetails = result as! NSDictionary
            guard let firstName = fbDetails["first_name"] as? String else { return }
            //guard let gender = fbDetails["gender"] as? String else { return }
            guard let birthday = fbDetails["birthday"] as? String else { return }
            let age = self.calculateAge(birthday: birthday)
            let user = UserModel(name: firstName, age: age, imageNames: self.modelController.getMockImageNames(), mainImageName: self.modelController.getMockImageNames()[0], work: "UW-Madison", bio: "")
            self.facebookUserDataDelegate?.didGetUserInfo(user: user)
        }
    }
}


