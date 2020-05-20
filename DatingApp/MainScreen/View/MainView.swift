//
//  MainView.swift
//  DatingApp
//
//  Created by Vy Le on 4/4/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class MainView : UIView {
    // MARK: - Properties
    private var swipeStackContainer = SwipeCardStackContainer()
    private let likeButton = BottomButton(imageName: "heart.fill", color: .robinBlue)
    private let dislikeButton = BottomButton(imageName: "heart.slash.fill", color: .amour)
    private let profileButton = HeaderButton(imageName: "person.fill")
    private let messageButton = HeaderButton(imageName: "message.fill")
    private let customAlertView = CustomAlertView(type: .deniedLocationAccess)
    private let searchingAnimation = SearchingAnimationView()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        setupSelf()
        addSubViews()
        setupConstraints()
    }
    
    private func setupSelf() {
        self.backgroundColor = UIColor.mainBackgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubViews() {
        addSubview(customAlertView)
        addSubview(profileButton)
        addSubview(messageButton)
        addSubview(swipeStackContainer)
        addSubview(dislikeButton)
        addSubview(likeButton)
        addSubview(searchingAnimation)
        sendSubviewToBack(searchingAnimation)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            customAlertView.topAnchor.constraint(equalTo: topAnchor),
            customAlertView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customAlertView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customAlertView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
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
        NSLayoutConstraint.activate([
            searchingAnimation.topAnchor.constraint(equalTo: profileButton.bottomAnchor),
            searchingAnimation.leftAnchor.constraint(equalTo: self.leftAnchor),
            searchingAnimation.rightAnchor.constraint(equalTo: self.rightAnchor),
            searchingAnimation.bottomAnchor.constraint(equalTo: likeButton.topAnchor),
        ])
    }
    
    func addDelegate(viewController: MainViewController) {
        swipeStackContainer.addDelegate(viewController: viewController)
    }
    
    func reloadSwipeViews() {
        swipeStackContainer.reloadData()
    }
    
    // MARK: Selectors
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
    
    func setDoneSelector(selector: Selector, target: UIViewController) {
        customAlertView.setDoneSelector(selector: selector, target: target)
    }
}

// MARK: - AlertView
extension MainView {
    func showAlert() {
        customAlertView.isHidden = false
        bringSubviewToFront(customAlertView)
    }
    
    func hideAlert() {
        customAlertView.isHidden = true
    }
}
