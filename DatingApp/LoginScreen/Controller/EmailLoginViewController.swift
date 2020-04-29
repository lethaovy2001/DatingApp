//
//  EmailLoginViewController.swift
//  DatingApp
//
//  Created by Vy Le on 4/29/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class EmailLoginViewController: UIViewController {
    private let mainView: EmailLoginView = {
        let view = EmailLoginView(frame: .zero)
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
        mainView.setLoginSelector(selector: #selector(loginWithEmail), target: self)
        mainView.setBackButtonSelector(selector: #selector(backButtonPressed), target: self)
    }
    
    //MARK: Actions
    @objc func loginWithEmail() {
        guard let email = mainView.getEmailText(), let password = mainView.getPasswordText()else {
            print("***** Form is not valid")
            return
        }
        firebaseService.authenticateUsingEmail(email: email, password: password, {
            let vc = MainViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        })        
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
