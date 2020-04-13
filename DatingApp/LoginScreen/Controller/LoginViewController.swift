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
    private var facebookAuth: FacebookAuthenticator!
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        facebookAuth = FacebookAuthenticator(viewController: self)
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
    
    //MARK: Actions
    @objc func loginWithFacebook() {
        facebookAuth.facebookLoginDelegate = self
        facebookAuth.loginPressed {
            self.authenticateWithFirebase {
                self.facebookAuth.getFBUserInfo()
                self.goToMainViewController()
            }
        }
    }
    
    private func goToMainViewController() {
        self.navigationController?.popToRootViewController(animated: false)
    }
}

extension LoginViewController: FacebookLoginDelegate {
    func getUserInfo(values: [String: AnyObject]) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        self.updateDatabase(with: userID, values: values)
    }
}




