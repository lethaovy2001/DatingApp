//
//  ViewController.swift
//  DatingApp
//
//  Created by Vy Le on 1/18/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    private let mainView: LoginMainView = {
        let view = LoginMainView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var facebookAuth: FacebookAuthenticator!
    private var firebaseService: FirebaseService!
    private var modelController = MainModelController()
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        facebookAuth = FacebookAuthenticator(viewController: self)
        firebaseService = FirebaseService()
        setupUI()
        setSelectors()
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
    
    private func setSelectors() {
        mainView.setFbLoginSelector(selector: #selector(loginWithFacebook), target: self)
        mainView.setEmailLoginSelector(selector: #selector(loginWithEmail), target: self)
    }
    
    //MARK: Actions
    @objc func loginWithFacebook() {
        facebookAuth.loginPressed {
            self.firebaseService.authenticateWithFirebase(accessToken: self.facebookAuth.getFBAccessToken(), {
                self.facebookAuth.getFBUserInfo({ data in
                    self.modelController.update(data: data)
                    self.goToMainViewController()
                })
            })
        }
       
    }
    
    @objc func loginWithEmail() {
        let vc = EmailLoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func goToMainViewController() {
        self.navigationController?.popToRootViewController(animated: false)
    }
}




