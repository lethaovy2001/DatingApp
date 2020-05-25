//
//  AppLogoView.swift
//  DatingApp
//
//  Created by Vy Le on 5/19/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import Lottie

class AppLogoView: UIView {
    private var appLogo: AnimationView = {
        let animationView = AnimationView(name: Constants.loveAnimation)
        animationView.contentMode = .scaleAspectFill
        animationView.play()
        animationView.loopMode = .repeat(.infinity)
        animationView.animationSpeed = 3
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
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
        setUpSelf()
        addSubViews()
        setupConstraints()
    }
    
    private func setUpSelf() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        self.accessibilityIdentifier = "appLogo"
    }
    
    private func addSubViews() {
        self.addSubview(appLogo)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            appLogo.leftAnchor.constraint(equalTo: leftAnchor),
            appLogo.rightAnchor.constraint(equalTo: rightAnchor),
            appLogo.topAnchor.constraint(equalTo: topAnchor),
            appLogo.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
