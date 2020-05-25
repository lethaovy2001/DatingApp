//
//  EmailLoginViewController.swift
//  DatingApp
//
//  Created by Vy Le on 4/29/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class EmailLoginViewController : UIViewController {
    // MARK: - Properties
    private let mainView = EmailLoginView()
    private let auth: Authentication
    var keyboardDelegate: KeyboardDelegate?
    
    // MARK: - Initializer
    init(authentication: Authentication) {
        self.auth = authentication
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "emailLoginView"
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardObservers()
    }
    
    // MARK: - Setup
    private func setup() {
        setupUI()
        setSelectors()
        mainView.addDelegate(viewController: self)
        mainView.addTapGesture(target: self, selector: #selector(dismissKeyboard))
    }
    
    private func setupUI() {
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
        mainView.setLoginSelector(selector: #selector(loginWithEmail), target: self)
        mainView.setBackButtonSelector(selector: #selector(backButtonPressed), target: self)
    }
    
    //MARK: Actions
    @objc private func loginWithEmail() {
        guard
            let email = mainView.getEmailText(),
            let password = mainView.getPasswordText()
        else { return }
        auth.logUserIn(withEmail: email, password: password) { signInError in
            if let error = signInError {
                self.mainView.showError(message: error)
                return
            }
            let vc = MainViewController(authentication: self.auth, database: FirebaseService.shared)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc private func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Keyboards
extension EmailLoginViewController {
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func handleKeyboardWillHide(notification: NSNotification) {
        keyboardDelegate?.hideKeyboard()
        performKeyboardAnimation(notification: notification)
    }
    
    @objc private func handleKeyboardWillShow(notification: NSNotification) {
        let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue ?? CGRect(x: 0, y: 0, width: 0, height: 0)
        mainView.getKeyboard(frame: keyboardFrame)
        keyboardDelegate?.showKeyboard()
        performKeyboardAnimation(notification: notification)
    }
    
    private func performKeyboardAnimation(notification: NSNotification) {
        let keyboardDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        UIView.animate(withDuration: keyboardDuration!) {
            self.view.layoutIfNeeded()
        }
    }
}
