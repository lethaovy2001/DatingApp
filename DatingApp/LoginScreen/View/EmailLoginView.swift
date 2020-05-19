//
//  EmailLoginView.swift
//  DatingApp
//
//  Created by Vy Le on 4/29/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import Lottie

class EmailLoginView: UIView {
    // MARK: - Properties
    private let appLogo = AppLogoView()
    private let emailLabel = SectionTitleLabel(title: "Email")
    private let emailTextField = CustomTextField(placeholder: "Email", keyboardType: .emailAddress)
    private let passwordTextField = PasswordTextField()
    private let loginButton = RoundedButton(title: "LOG IN", color: UIColor.amour)
    private let backButton = BackButton()
    private let errorLabel = ErrorLabel()
    private var containerView = CustomContainerView()
    private var keyboardFrame = CGRect()
    private var containerBotomAnchor: NSLayoutConstraint?
    private var appLogoTopAnchor: NSLayoutConstraint?
    
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        setupSelf()
        addSubViews()
        setupConstraints()
        setUpErrorLabel()
    }
    
    private func setupSelf() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubViews() {
        addSubview(containerView)
        addSubview(loginButton)
        containerView.addSubview(emailLabel)
        containerView.addSubview(emailTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(errorLabel)
        containerView.addSubview(appLogo)
        containerView.addSubview(backButton)
    }
    
    private func setupConstraints() {
        containerBotomAnchor = containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        appLogoTopAnchor = appLogo.topAnchor.constraint(equalTo: self.topAnchor, constant: 90)
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: leftAnchor),
            containerView.rightAnchor.constraint(equalTo: rightAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerBotomAnchor!
        ])
        NSLayoutConstraint.activate([
            appLogoTopAnchor!,
            appLogo.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            appLogo.heightAnchor.constraint(equalToConstant: 140),
            appLogo.widthAnchor.constraint(equalToConstant: 250)
        ])
        NSLayoutConstraint.activate([
            emailLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -72),
            emailLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            emailLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            emailLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -36)
        ])
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            emailTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            emailTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -36)
        ])
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 12),
            passwordTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            passwordTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -36)
        ])
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 6),
            errorLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            errorLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -36)
        ])
        NSLayoutConstraint.activate([
            loginButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            loginButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -36),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 60),
            loginButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            backButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 54)
        ])
    }
    
    private func setUpErrorLabel() {
        errorLabel.isHidden = true
        errorLabel.numberOfLines = 2
    }
    
    func addDelegate(viewController: EmailLoginViewController) {
        viewController.keyboardDelegate = self
    }
    
    func addTapGesture(target: UIViewController, selector: Selector) {
        let tapRecognizer = UITapGestureRecognizer(target: target, action: selector)
        tapRecognizer.cancelsTouchesInView = false
        containerView.addGestureRecognizer(tapRecognizer)
    }
    
    func setLoginSelector(selector: Selector, target: UIViewController) {
        loginButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func setBackButtonSelector(selector: Selector, target: UIViewController) {
        backButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func getEmailText() -> String? {
        return emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func getPasswordText() -> String? {
        return passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func getKeyboard(frame: CGRect) {
        self.keyboardFrame = frame
    }
    
    func showError(message: String) {
        errorLabel.isHidden = false
        errorLabel.text = message
    }
}

// MARK: - KeyboardDelegate
extension EmailLoginView: KeyboardDelegate {
    func showKeyboard() {
        containerBotomAnchor?.constant = -self.keyboardFrame.height + 20
        appLogoTopAnchor?.constant = 36
        UIView.animate(withDuration: 0.6) {
            self.appLogo.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        }
    }
    
    func hideKeyboard() {
        containerBotomAnchor?.constant = 0
        appLogoTopAnchor?.constant = 90
        UIView.animate(withDuration: 0.6) {
            self.appLogo.transform = CGAffineTransform.identity
        }
    }
}
