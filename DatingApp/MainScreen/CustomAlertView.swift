//
//  CustomAlertView.swift
//  DatingApp
//
//  Created by Vy Le on 4/16/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import Lottie

class CustomAlertView: UIView {
    private let containerView = CustomContainerView(cornerRadius: 10)
    private let titleLabel = CustomLabel(text: "Thank You", textColor: UIColor.darkGray, textSize: 30, textWeight: .heavy)
    private let descriptionTextView = CustomTextView(text: "You are now able to see others in the same area. You are now able to see others in the same area", textAlignment: .center)
    private let doneButton = CustomButton(title: "DONE", color: Constants.Colors.amour, cornerRadius: 5)
    private let animationView: AnimationView = {
        let animationView = AnimationView(name: Constants.searchLocationAnimation)
        animationView.contentMode = .scaleAspectFill
        animationView.play()
        animationView.loopMode = .repeat(.infinity)
        animationView.animationSpeed = 3
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
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        self.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(animationView)
        containerView.addSubview(descriptionTextView)
        containerView.addSubview(doneButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
        ])
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16)
        ])
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            animationView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            animationView.heightAnchor.constraint(equalToConstant: 150),
            animationView.widthAnchor.constraint(equalToConstant: 150)
        ])
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 16),
            descriptionTextView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            descriptionTextView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16),
            descriptionTextView.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: -12)
        ])
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: -12),
            doneButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            doneButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16),
            doneButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            doneButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
}
