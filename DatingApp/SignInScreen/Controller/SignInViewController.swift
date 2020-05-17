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
    var keyboardDelegate: KeyboardDelegate?
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseService = FirebaseService()
        setupUI()
        setSelectors()
        mainView.addDelegate(viewController: self)
        mainView.addTapGesture(target: self, selector: #selector(dismissKeyboard))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardObservers()
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
            return
        }
        firebaseService.createUser(email: email, password: password, { errorMessage in
            if let error = errorMessage {
                self.mainView.showError(message: error)
                return
            }
            let vc = MainViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        })
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: Keyboards
extension SignInViewController {
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func handleKeyboardWillHide(notification: NSNotification) {
        keyboardDelegate?.hideKeyboard()
        performKeyboardAnimation(notification: notification)
    }
    
    @objc func handleKeyboardWillShow(notification: NSNotification) {
        let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue ?? CGRect(x: 0, y: 0, width: 0, height: 0)
        mainView.getKeyboard(frame: keyboardFrame)
        keyboardDelegate?.showKeyboard()
        performKeyboardAnimation(notification: notification)
    }
    
    private func performKeyboardAnimation(notification: NSNotification) {
        let keyboardDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.view.layoutIfNeeded()
        })
    }
}

