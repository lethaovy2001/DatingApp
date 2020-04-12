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

class LoginViewController: UIViewController {
    
    private let mainView:LoginMainView = {
        let view = LoginMainView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var db: Firestore!
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        setupUI()
        mainView.setLoginSelector(selector: #selector(loginWithFacebook), target: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        guard let date = dateFormatter.date(from: birthday) else { return 0 }
        let now = Date()
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: date, to: now)
        let age = ageComponents.year!
        return age
    }
    
    // MARK: Firebase
    private func authenticateWithFirebase(_ completion : @escaping()->()) {
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if error != nil {
                print(String(describing: error))
                return
            }
            print("Successfully log user into firebase")
            completion()
        }
    }
    
    private func updateDatabase(with uid: String, values: [String: AnyObject]) {
        db.collection("users").document(uid).setData(values) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    // MARK: Facebook
    private func getFBUserInfo() {
        GraphRequest(graphPath: "/me", parameters: ["fields": "first_name, email, birthday, gender"]).start { (connection, result, err) in
            if err != nil {
                print("Failed to start graph request:", err!)
                return
            }
            let fbDetails = result as! NSDictionary
            guard let userID = Auth.auth().currentUser?.uid else { return }
            guard let firstName = fbDetails["first_name"] else { return }
            guard let gender = fbDetails["gender"] else { return }
            guard let birthday = fbDetails["birthday"] as? String else { return }
            let age = self.calculateAge(birthday: birthday)
            let dictionary = ["uid": userID,
            "first_name": firstName,
            "age": age,
            "gender": gender] as [String : AnyObject]
            self.updateDatabase(with: userID, values: dictionary)
        }
    }
    
    //MARK: Actions
    @objc func loginWithFacebook() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email", "user_birthday, user_gender"], from: self) { (result, error) in
            if error != nil {
                print("***** Error: \(error!)")
            } else if result?.isCancelled == true {
                print("***** Cancel")
            } else {
                UserDefaults.standard.setIsLoggedIn(value: true)
                UserDefaults.standard.synchronize()
                self.authenticateWithFirebase {
                    self.getFBUserInfo()
                    self.goToMainViewController()
                }
            }
        }
    }
    
    private func goToMainViewController() {
        self.navigationController?.popToRootViewController(animated: false)
    }
}


