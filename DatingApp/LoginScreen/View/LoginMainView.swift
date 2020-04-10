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
    private let fbLoginButton = RoundedButton(title: "LOG IN WITH FACEBOOK", color: Constants.Colors.fbColor)
    
    private let appLogo: AnimationView = {
        let animationView = AnimationView(name: Constants.loveAnimation)
        animationView.contentMode = .scaleAspectFill
        animationView.play()
        animationView.loopMode = .repeat(.infinity)
        animationView.animationSpeed = 3
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // MARK: Setup
    private func addSubViews() {
        addSubview(fbLoginButton)
        addSubview(appLogo)
    }
    
    private func setup() {
        addSubViews()
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            appLogo.centerXAnchor.constraint(equalTo: centerXAnchor),
            appLogo.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -200),
            appLogo.heightAnchor.constraint(equalToConstant: 250),
            appLogo.widthAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            fbLoginButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            fbLoginButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -36),
            fbLoginButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
            fbLoginButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func setLoginSelector(selector: Selector, target: UIViewController) {
        fbLoginButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
