//
//  SignInView.swift
//  DatingApp
//
//  Created by Vy Le on 5/13/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import Lottie

class SignInView: UIView {
    private let appLogo: AnimationView = {
        let animationView = AnimationView(name: Constants.loveAnimation)
        animationView.contentMode = .scaleAspectFill
        animationView.play()
        animationView.loopMode = .repeat(.infinity)
        animationView.animationSpeed = 3
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    private let signInLabel = SectionTitleLabel(title: "Sign In")
    private let nameTextField = CustomTextField(placeholder: "Name")
    private let emailTextField = CustomTextField(placeholder: "Email")
    private let passwordTextField = CustomTextField(placeholder: "Password")
    private let signInButton = RoundedButton(title: "SIGN IN", color: UIColor.amour)
    private let backButton = CustomButton(imageName: "chevron.left", size: 22, color: UIColor.amour, cornerRadius: nil, shadowColor: nil, backgroundColor: .clear)
    private var keyboardFrame = CGRect()
    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var containerBotomAnchor: NSLayoutConstraint?
    
    // MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubViews()
        setupConstraints()
    }
    
    // MARK: Setup
    private func addSubViews() {
        addSubview(containerView)
        containerView.addSubview(signInLabel)
        containerView.addSubview(nameTextField)
        containerView.addSubview(emailTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(appLogo)
        containerView.addSubview(signInButton)
        containerView.addSubview(backButton)
    }
    
    private func setupConstraints() {
        containerBotomAnchor = containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: leftAnchor),
            containerView.rightAnchor.constraint(equalTo: rightAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerBotomAnchor!
        ])
        NSLayoutConstraint.activate([
            appLogo.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            appLogo.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -200),
            appLogo.heightAnchor.constraint(equalToConstant: 250),
            appLogo.widthAnchor.constraint(equalToConstant: 250)
        ])
        NSLayoutConstraint.activate([
            signInLabel.topAnchor.constraint(equalTo: appLogo.bottomAnchor, constant: 12),
            signInLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            signInLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 36),
            signInLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -36)
        ])
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 8),
            nameTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 36),
            nameTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -36)
        ])
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 12),
            emailTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            emailTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -36)
        ])
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 12),
            passwordTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            passwordTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -36)
        ])
        NSLayoutConstraint.activate([
            signInButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            signInButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -36),
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 36),
            signInButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            backButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 54)
        ])
    }
    
    func addDelegate(viewController: SignInViewController) {
        viewController.keyboardDelegate = self
    }
    
    func addTapGesture(target: UIViewController, selector: Selector) {
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(
            target: target,
            action: selector)
        tapRecognizer.cancelsTouchesInView = false
        self.addGestureRecognizer(tapRecognizer)
    }
    
    func setLoginSelector(selector: Selector, target: UIViewController) {
        signInButton.addTarget(target, action: selector, for: .touchUpInside)
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
    
    func getNameText() -> String? {
        return nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func getKeyboard(frame: CGRect) {
        self.keyboardFrame = frame
    }
}

extension SignInView: KeyboardDelegate {
    func showKeyboard() {
        containerBotomAnchor?.constant = -self.keyboardFrame.height 
    }
    
    func hideKeyboard() {
        containerBotomAnchor?.constant = 0
    }
}


