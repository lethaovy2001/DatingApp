//
//  ViewController.swift
//  DatingApp
//
//  Created by Vy Le on 1/18/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import FirebaseDatabase

class LoginViewController: UIViewController {
    
    private let mainView:LoginMainView = {
        let view = LoginMainView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        mainView.setLoginSelector(selector: #selector(loginWithFacebook), target: self)
    }
    
    // MARK: Setup
    private func setupUI() {
        view.addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        view.backgroundColor = .white
    }
    
    private func calculateAge(birthday: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        if let date = dateFormatter.date(from: birthday) {
            let now = Date()
            let calendar = Calendar.current
            let ageComponents = calendar.dateComponents([.year], from: date, to: now)
            let age = ageComponents.year!
            print(age)
            return age
        }
        return 0
    }
    
    func getFBUserInfo() {
        GraphRequest(graphPath: "/me", parameters: ["fields": "first_name, email, birthday, gender"]).start { (connection, result, err) in
            if err != nil {
                print("Failed to start graph request:", err)
                return
            }
            let fbDetails = result as! NSDictionary
            guard let userID = Auth.auth().currentUser?.uid else { return }
            guard let firstName = fbDetails["first_name"] else { return }
            guard let gender = fbDetails["gender"] else { return }
            
            var age = 0
            if let birthday = fbDetails["birthday"] as? String {
                print(birthday)
                age = self.calculateAge(birthday: birthday)
            }
            
            let dictionary = ["uid": userID,
            "first_name": firstName,
            "age": age,
            "gender": gender] as [String : AnyObject]
            self.registerUserIntoDatabaseWithUID(uid: userID, values: dictionary)
        }
    }
    
    //TODO: Handle error
    @objc func loginWithFacebook() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email", "user_birthday, user_gender"], from: self) { (result, error) in
            if error != nil {
                print("***** Error: \(error!)")
            } else if result?.isCancelled == true {
                
                print("***** Cancel")
            } else {
                print("***** Log in with Facebook")
                UserDefaults.standard.setIsLoggedIn(value: true)
                UserDefaults.standard.synchronize()
                self.authenticateWithFirebase()
                self.getFBUserInfo()
//                let vc = MainViewController()
//                vc.modalPresentationStyle = .fullScreen
//                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    private func authenticateWithFirebase() {
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if error != nil {
                print("Error Auth \(String(describing: error))")
                return
            }
        }
    }
    
    private func registerUserIntoDatabaseWithUID(uid: String, values: [String: AnyObject]) {
        var ref: DatabaseReference!
        ref = Database.database().reference()

        let usersReference = ref.child("users").child(uid)
        usersReference.setValue(values, withCompletionBlock: { (err, ref) in
            if err != nil {
                print("***** \(String(describing: err))")
                return
            }
            print("****** Successfully save user in Firebase")
            self.dismiss(animated: true, completion: nil)
        })
    }
}
