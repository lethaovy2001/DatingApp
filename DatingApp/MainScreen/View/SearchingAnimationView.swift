//
//  SearchingAnimationView.swift
//  DatingApp
//
//  Created by Vy Le on 5/12/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import Lottie

class SearchingAnimationView: UIView {
    private let titleLabel = CustomLabel(text: "Searching for more users...", textColor: UIColor.darkGray, textSize: 20, textWeight: .semibold)
    private var animationView: AnimationView = {
        let animationView = AnimationView(name: "people")
        animationView.play()
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .repeat(.infinity)
        animationView.animationSpeed = 2
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    // MARK: Initializer
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setup() {
        setUpSelf()
        addSubviews()
        setupConstraints()
    }
    
    private func setUpSelf() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
    }
    
    private func addSubviews() {
        self.addSubview(titleLabel)
        self.addSubview(animationView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -64),
        ])
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 16),
            animationView.heightAnchor.constraint(equalToConstant: 150),
            animationView.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
}
