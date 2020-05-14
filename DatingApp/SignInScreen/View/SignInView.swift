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
    private var appLogo: AnimationView = {
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
    private let errorLabel = CustomLabel(text: "Error", textColor: UIColor.red, textSize: 14, textWeight: .regular)
    private var keyboardFrame = CGRect()
    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var containerBotomAnchor: NSLayoutConstraint?
    private var appLogoTopAnchor: NSLayoutConstraint?
    
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
        setUpErrorLabel()
    }
    
    // MARK: Setup
    private func setUpErrorLabel() {
        errorLabel.isHidden = true
        errorLabel.numberOfLines = 2
    }
    
    private func addSubViews() {
        addSubview(containerView)
        addSubview(signInButton)
        containerView.addSubview(signInLabel)
        containerView.addSubview(nameTextField)
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
            signInLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -72),
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
            signInButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            signInButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -36),
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 48),
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
        containerView.addGestureRecognizer(tapRecognizer)
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
    
    func showError(message: String) {
        errorLabel.isHidden = false
        errorLabel.text = message
    }
}

extension SignInView: KeyboardDelegate {
    func showKeyboard() {
        containerBotomAnchor?.constant = -self.keyboardFrame.height + 20
        appLogoTopAnchor?.constant = 36
        UIView.animate(withDuration: 0.6, animations: {
            self.appLogo.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        })
    }
    
    func hideKeyboard() {
        containerBotomAnchor?.constant = 0
        appLogoTopAnchor?.constant = 90
        UIView.animate(withDuration: 0.6, animations: {
            self.appLogo.transform = CGAffineTransform.identity
        })
    }
}


