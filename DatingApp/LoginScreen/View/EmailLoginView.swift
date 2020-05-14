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
    private let appLogo: AnimationView = {
        let animationView = AnimationView(name: Constants.loveAnimation)
        animationView.contentMode = .scaleAspectFill
        animationView.play()
        animationView.loopMode = .repeat(.infinity)
        animationView.animationSpeed = 3
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    private let emailLabel = SectionTitleLabel(title: "Email")
    private let emailTextField = CustomTextField(placeholder: "Email")
    private let passwordTextField = CustomTextField(placeholder: "Password")
    private let loginButton = RoundedButton(title: "LOG IN", color: UIColor.amour)
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
        containerView.addSubview(emailLabel)
        containerView.addSubview(emailTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(appLogo)
        containerView.addSubview(loginButton)
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
            emailLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
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
            loginButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            loginButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -36),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 36),
            loginButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            backButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 54)
        ])
    }
    
    func addDelegate(viewController: EmailLoginViewController) {
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
}

extension EmailLoginView: KeyboardDelegate {
    func showKeyboard() {
        containerBotomAnchor?.constant = -self.keyboardFrame.height
    }
    
    func hideKeyboard() {
        containerBotomAnchor?.constant = 0
    }
}
