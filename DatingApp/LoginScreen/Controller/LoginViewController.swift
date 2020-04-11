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
    
    // TODO: Handle error
    @objc func loginWithFacebook() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
            if error != nil {
                print("***** Error: \(error!)")
            } else if result?.isCancelled == true {
                print("***** Cancel")
            } else {
                print("***** Log in with Facebook")
                UserDefaults.standard.setIsLoggedIn(value: true)
                UserDefaults.standard.synchronize()
                self.navigationController?.popToRootViewController(animated: false)
            }
        }
    }
}

