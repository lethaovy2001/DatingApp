//
//  MainView.swift
//  DatingApp
//
//  Created by Vy Le on 4/4/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class MainView: UIView {
    private let cardView = SwipeCardView()
    private var swipeStackContainer = SwipeCardStackContainer()
    private let likeButton: CustomButton = {
        let button = CustomButton(imageName: "heart.fill", size: 25, color: .cyan, cornerRadius: (Constants.PaddingValues.likeButtonHeight/2), shadowColor: Constants.Colors.lightGray, backgroundColor: .white)
        return button
    }()
    private let dislikeButton: CustomButton = {
        let button = CustomButton(imageName: "heart.slash.fill", size: 25, color: .red, cornerRadius: Constants.PaddingValues.likeButtonHeight/2, shadowColor: Constants.Colors.lightGray, backgroundColor: .white)
        return button
    }()
    private let profileButton = CustomButton(imageName: "person.fill", size: 25, color: Constants.Colors.lightGray, cornerRadius: nil, shadowColor: nil, backgroundColor: .clear)
    private let messageButton = CustomButton(imageName: "message.fill", size: 25, color: Constants.Colors.lightGray, cornerRadius: nil, shadowColor: nil, backgroundColor: .clear)
    
    // MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        addSubViews()
        setupConstraints()
    }
    
    // MARK: Setup
    private func setup() {
        backgroundColor = Constants.Colors.mainBackgroundColor
        addSubViews()
        setupConstraints()
    }
    
    private func addSubViews() {
        addSubview(profileButton)
        addSubview(messageButton)
        addSubview(swipeStackContainer)
        addSubview(dislikeButton)
        addSubview(likeButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileButton.heightAnchor.constraint(equalToConstant: 60),
            profileButton.widthAnchor.constraint(equalToConstant: 60),
            profileButton.safeAreaLayoutGuide.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20),
            profileButton.safeAreaLayoutGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 6)
        ])
        
        NSLayoutConstraint.activate([
            messageButton.heightAnchor.constraint(equalToConstant: 60),
            messageButton.widthAnchor.constraint(equalToConstant: 60),
            messageButton.safeAreaLayoutGuide.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20),
            messageButton.safeAreaLayoutGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 6)
        ])
        
        NSLayoutConstraint.activate([
            likeButton.heightAnchor.constraint(equalToConstant: Constants.PaddingValues.likeButtonHeight),
            likeButton.widthAnchor.constraint(equalToConstant: Constants.PaddingValues.likeButtonHeight),
            likeButton.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
            likeButton.safeAreaLayoutGuide.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 64)
            
        ])
        NSLayoutConstraint.activate([
            dislikeButton.heightAnchor.constraint(equalToConstant: Constants.PaddingValues.likeButtonHeight),
            dislikeButton.widthAnchor.constraint(equalToConstant: Constants.PaddingValues.likeButtonHeight),
            dislikeButton.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
            dislikeButton.safeAreaLayoutGuide.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -64)
        ])
        
        NSLayoutConstraint.activate([
            swipeStackContainer.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            swipeStackContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            swipeStackContainer.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 3.5/5),
            swipeStackContainer.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 6)
        ])
    }
    
    func setDataSource(uiViewController: UIViewController) {
        swipeStackContainer.dataSource = uiViewController as? SwipeableCardDataSource
    }
    
    func setLikeSelector(selector: Selector, target: UIViewController) {
        likeButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func setDislikeSelector(selector: Selector, target: UIViewController) {
        dislikeButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func setProfileSelector(selector: Selector, target: UIViewController) {
        profileButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func setMessageSelector(selector: Selector, target: UIViewController) {
        messageButton.addTarget(target, action: selector, for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
