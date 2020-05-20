//
//  LoginMainView.swift
//  DatingApp
//
//  Created by Duy Le on 4/3/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class LoginMainView : UIView {
    // MARK: Properties
    private let fbLoginButton = RoundedButton(title: "LOG IN WITH FACEBOOK", color: UIColor.fbColor)
    private let emailLoginButton = RoundedButton(title: "LOG IN WITH EMAIL", color: UIColor.amour)
    private let signInLabel = CustomLabel(text: "Don't have an account?", textColor: UIColor.darkGray, textSize: 16, textWeight: .regular)
    private let signInButton = CustomButton(title: "Sign In", textColor: UIColor.amour, textSize: 16, textWeight: .bold)
    private let customStackView = CustomStackView(axis: .horizontal, distribution: .fill)
    private let appLogo = AppLogoView()
    private let customAlertView = CustomAlertView(type: .failLoginWithFacebook)
    
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
        addSubViews()
        setupConstraints()
    }
    
    private func addSubViews() {
        addSubview(customAlertView)
        addSubview(fbLoginButton)
        addSubview(emailLoginButton)
        addSubview(appLogo)
        addSubview(customStackView)
        customStackView.addArrangedSubview(signInLabel)
        customStackView.addArrangedSubview(signInButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            customAlertView.topAnchor.constraint(equalTo: topAnchor),
            customAlertView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customAlertView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customAlertView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            appLogo.centerXAnchor.constraint(equalTo: centerXAnchor),
            appLogo.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -200),
            appLogo.heightAnchor.constraint(equalToConstant: 250),
            appLogo.widthAnchor.constraint(equalToConstant: 250)
        ])
        NSLayoutConstraint.activate([
            emailLoginButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            emailLoginButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -36),
            emailLoginButton.bottomAnchor.constraint(equalTo: fbLoginButton.topAnchor, constant: -12),
            emailLoginButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            fbLoginButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            fbLoginButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -36),
            fbLoginButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
            fbLoginButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            customStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            customStackView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -36),
            customStackView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    // MARK: Selectors
    func setFbLoginSelector(selector: Selector, target: UIViewController) {
        fbLoginButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func setEmailLoginSelector(selector: Selector, target: UIViewController) {
        emailLoginButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func setSignInSelector(selector: Selector, target: UIViewController) {
        signInButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func setDoneSelector(selector: Selector, target: UIViewController) {
        customAlertView.setDoneSelector(selector: selector, target: target)
    }
}

// MARK: - AlertView
extension LoginMainView {
    func showAlert() {
        customAlertView.isHidden = false
        bringSubviewToFront(customAlertView)
    }
    
    func hideAlert() {
        customAlertView.isHidden = true
    }
}
