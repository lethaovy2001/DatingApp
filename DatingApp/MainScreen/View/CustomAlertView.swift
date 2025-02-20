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
    private var titleLabel: CustomLabel!
    private var descriptionTextView: CustomTextView!
    private var animationView: AnimationView!
    private let doneButton = CustomButton(title: "DONE", color: UIColor.amour, cornerRadius: 5)
    private var type: AlertType!
    private var title: String!
    private var message: String!
    private var animationName: String!
    private var animationSpeed: CGFloat!
    
    enum AlertType {
        case deniedLocationAccess
        case newMessage
        case failLoginWithFacebook
    }
    
    // MARK: Initializer
    init(type: AlertType) {
        super.init(frame: .zero)
        self.type = type
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews() {
        titleLabel = CustomLabel(text: self.title, textColor: UIColor.darkGray, textSize: 26, textWeight: .heavy)
        descriptionTextView = CustomTextView(text: self.message, textAlignment: .center)
        animationView = AnimationView(name: self.animationName)
        animationView.play()
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .repeat(.infinity)
        animationView.animationSpeed = animationSpeed
        animationView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: Setup
    private func setup() {
        setupSelf()
        setupDescription()
        initViews()
        addSubviews()
        setupConstraints()
    }
    
    private func setupSelf() {
        self.isHidden = true
        self.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.accessibilityIdentifier = "alerView"
    }
    
    private func setupDescription() {
        let number = Int.random(in: 0...3)
        switch self.type {
        case .deniedLocationAccess:
            title = Constants.Strings.DeniedLocationAccess.title
            message = Constants.Strings.DeniedLocationAccess.message
            animationName = Constants.searchLocationAnimation
            animationSpeed = 2
        case .newMessage:
            title = Constants.Strings.NewMessage.title
            message = Constants.Strings.NewMessage.message
            animationName = "match\(number)"
            animationSpeed = 2
        case .failLoginWithFacebook:
            title = Constants.Strings.FailLoginWithFacebook.title
            message = Constants.Strings.FailLoginWithFacebook.message
            animationName = Constants.failAnimation
            animationSpeed = 1
        default:
            title = Constants.Strings.Default.title
            message = Constants.Strings.Default.message
            animationName = Constants.searchLocationAnimation
            animationSpeed = 1
        }
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
            containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16)
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
    
    func setDoneSelector(selector: Selector, target: UIViewController) {
        doneButton.addTarget(target, action: selector, for: .touchUpInside)
    }
}
