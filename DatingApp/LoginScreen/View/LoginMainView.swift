//
//  LoginMainView.swift
//  DatingApp
//
//  Created by Duy Le on 4/3/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import Foundation
import UIKit

class LoginMainView: UIView {
    private let fbLoginButton: RoundedButton = {
        let button = RoundedButton(title: "LOG IN WITH FACEBOOK", color: Constants.Colors.fbColor)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let appLogo: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "giraffe"))
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setLoginSelector(selector: Selector, target: UIViewController) {
        fbLoginButton.addTarget(target, action: selector, for: .touchUpInside)
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
            appLogo.heightAnchor.constraint(equalToConstant: 120),
            appLogo.widthAnchor.constraint(equalToConstant: 120)
        ])
        NSLayoutConstraint.activate([
            fbLoginButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            fbLoginButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -36),
            fbLoginButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
            fbLoginButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
