//
//  LoginMainView.swift
//  DatingApp
//
//  Created by Duy Le on 4/3/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class LoginMainView: UIView {
    
    private let fbLoginButton = RoundedButton(title: "LOG IN WITH FACEBOOK", color: UIColor.fbColor)
    private let emailLoginButton = RoundedButton(title: "LOG IN WITH EMAIL", color: UIColor.amour)
    private let signInLabel = CustomLabel(text: "Don't have an account?", textColor: UIColor.darkGray, textSize: 16, textWeight: .regular)
    private let signInButton = CustomButton(title: "Sign In", textColor: UIColor.amour, textSize: 16, textWeight: .bold)
    private let customStackView = CustomStackView(axis: .horizontal, distribution: .fill)
    
    private let appLogo: AnimationView = {
        let animationView = AnimationView(name: Constants.loveAnimation)
        animationView.contentMode = .scaleAspectFill
        animationView.play()
        animationView.loopMode = .repeat(.infinity)
        animationView.animationSpeed = 3
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    // MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        addSubViews()
        setupConstraints()
    }
    
    private func addSubViews() {
        addSubview(fbLoginButton)
        addSubview(emailLoginButton)
        addSubview(appLogo)
        addSubview(customStackView)
        customStackView.addArrangedSubview(signInLabel)
        customStackView.addArrangedSubview(signInButton)
    }
    
    private func setupConstraints() {
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
