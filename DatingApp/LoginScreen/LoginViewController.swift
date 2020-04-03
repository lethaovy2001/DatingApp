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
    
    private let fbLoginButton: RoundedButton = {
        let button = RoundedButton(title: "LOG IN WITH FACEBOOK", color: Constants.Colors.fbColor)
       button.addTarget(self, action: #selector(loginWithFacebook), for: .touchUpInside)
        return button
    }()
    
    private let appLogo: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "giraffe"))
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv;
    }()
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    // MARK: Setup
    private func setUp() {
        addSubViews()
        setupConstraints()
        view.backgroundColor = .white
    }
    
    private func addSubViews() {
        view.addSubview(fbLoginButton)
        view.addSubview(appLogo)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            appLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200),
            appLogo.heightAnchor.constraint(equalToConstant: 120),
            appLogo.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            fbLoginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 36),
            fbLoginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -36),
            fbLoginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            fbLoginButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    //TODO: Handle error
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
                let vc = MainViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
                
            }
        }
    }
}

