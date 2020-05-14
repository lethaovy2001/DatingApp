//
//  SignInViewController.swift
//  DatingApp
//
//  Created by Vy Le on 5/13/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    private let mainView: SignInView = {
        let view = SignInView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var firebaseService: FirebaseService!
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseService = FirebaseService()
        setupUI()
        setSelectors()
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
        mainView.setLoginSelector(selector: #selector(signIn), target: self)
        mainView.setBackButtonSelector(selector: #selector(backButtonPressed), target: self)
    }
    
    //MARK: Actions
    @objc func signIn() {
        guard let email = mainView.getEmailText(), let password = mainView.getPasswordText(), let name = mainView.getNameText() else {
            print("***** Form is not valid")
            return
        }
        firebaseService.createUser(email: email, password: password, {
            let vc = MainViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        })
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}

