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
        addSubview(signInLabel)
        addSubview(nameTextField)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(appLogo)
        addSubview(signInButton)
        addSubview(backButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            appLogo.centerXAnchor.constraint(equalTo: centerXAnchor),
            appLogo.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -200),
            appLogo.heightAnchor.constraint(equalToConstant: 250),
            appLogo.widthAnchor.constraint(equalToConstant: 250)
        ])
        NSLayoutConstraint.activate([
            signInLabel.topAnchor.constraint(equalTo: appLogo.bottomAnchor, constant: 12),
            signInLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            signInLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            signInLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -36)
        ])
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 8),
            nameTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            nameTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -36)
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
            signInButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
            signInButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            backButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 54)
        ])
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
}
