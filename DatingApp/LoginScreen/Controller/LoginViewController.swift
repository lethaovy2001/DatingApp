//
//  ViewController.swift
//  DatingApp
//
//  Created by Vy Le on 1/18/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class LoginViewController : UIViewController {
    // MARK: - Properties
    private let mainView = LoginMainView()
    private var facebookAuth = FacebookAuthenticator()
    private let database: Database
    private let auth: Authentication
    
    // MARK: - Initializer
    init(authentication: Authentication, database: Database) {
        self.auth = authentication
        self.database = database
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setSelectors()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Setup
    private func setupUI() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainView)
        view.backgroundColor = .white
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setSelectors() {
        mainView.setFbLoginSelector(selector: #selector(loginWithFacebook), target: self)
        mainView.setEmailLoginSelector(selector: #selector(loginWithEmail), target: self)
        mainView.setSignInSelector(selector: #selector(signIn), target: self)
        mainView.setDoneSelector(selector: #selector(doneButtonPressed), target: self)
    }
    
    //MARK: Actions
    @objc private func loginWithFacebook() {
        facebookAuth.loginPressed(viewController: self) { isAlreadyLogin in
            self.auth.logUserIn(withCredential: self.facebookAuth.getFBAccessToken()) { loginError in
                if let error = loginError {
                    self.mainView.showAlert()
                    return
                }
                if isAlreadyLogin {
                    self.navigationController?.popToRootViewController(animated: false)
                } else {
                    self.facebookAuth.getFBUserInfo({ data in
                        if let userInfo = data as? [String: Any] {
                            var user = UserModel(info: userInfo)
                            user.id = self.auth.getCurrentUserId()
                            let vc = PreferenceViewController(authentication: FirebaseService.shared, database: FirebaseService.shared)
                            vc.user = user
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    })
                }
            }
        }
    }
    
    @objc func loginWithEmail() {
        let vc = EmailLoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func signIn() {
        let vc = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func doneButtonPressed() {
        mainView.hideAlert()
    }
}




