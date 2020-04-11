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
        let now = Date()
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        var age = 0
        dateFormatter.dateFormat = "MM-dd-yyyy"
        if let date = dateFormatter.date(from: birthday) {
            let ageComponents = calendar.dateComponents([.year], from: date, to: now)
            age = ageComponents.year!
        }
        return age
    }
    
    private func getFBUserInfo() {
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
                age = self.calculateAge(birthday: birthday)
            }
            let dictionary = ["uid": userID, "first_name": firstName, "age": age, "gender": gender] as [String : AnyObject]
            self.updateDatabase(with: userID, values: dictionary)
            self.fetchUserInfo()
        }
    }
    
    //MARK: Actions
    //TODO: Handle error
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
                self.authenticateWithFirebase()
                self.getFBUserInfo()
//                let vc = MainViewController()
//                vc.modalPresentationStyle = .fullScreen
//                self.present(vc, animated: true, completion: nil)
            }
        }
    }
}

extension LoginViewController {
    
}

//MARK: Firebase
extension LoginViewController {
    private func authenticateWithFirebase() {
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if error != nil {
                print("Error Auth \(String(describing: error))")
                return
            }
        }
    }
    
    private func updateDatabase(with uid: String, values: [String: AnyObject]) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let usersReference = ref.child("users").child(uid)
        usersReference.setValue(values, withCompletionBlock: { (err, ref) in
            if err != nil {
                print(String(describing: err))
                return
            }
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    private func fetchUserInfo() {
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
                print(snapshot)
            if let dictonary = snapshot.value as? [String: AnyObject] {
                //TODO: display user info
            }
        }, withCancel: nil)
    }
}
