//
//  MainViewController.swift
//  DatingApp
//
//  Created by Vy Le on 1/21/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIGestureRecognizerDelegate {
    
    private let cardView = SwipeCardView()
    private var swipeStackContainer = SwipeCardStackContainer()
    
    private let likeButton: CustomButton = {
        let button = CustomButton(imageName: "heart.fill", size: 25, color: .cyan, addShadow: true, cornerRadius: Constants.PaddingValues.likeButtonHeight/2)
        button.addTarget(self, action: #selector(likePressed), for: .touchUpInside)
        return button
    }()
    
    private let dislikeButton: CustomButton = {
        let button = CustomButton(imageName: "heart.slash.fill", size: 25, color: .red, addShadow: true, cornerRadius: Constants.PaddingValues.likeButtonHeight/2)
        button.addTarget(self, action: #selector(dislikePressed), for: .touchUpInside)
        return button
    }()
    private let (profileButton) = CustomButton(imageName: "person.fill", size: 25, color: Constants.Colors.lightGray, addShadow: false, cornerRadius: nil)
    
    private let messageButton = CustomButton(imageName: "message.fill", size: 25, color: Constants.Colors.lightGray, addShadow: false, cornerRadius: nil)

    private let buttonStack: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .red
        stackView.spacing = 60
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let userImages = ["Vy.jpg", "Image1.jpg", "Image2.jpg"]
    private lazy var users = [
        SwipeCardModel(name: "Vy", age: 18, imageName: [userImages[1], userImages[2]]),
        SwipeCardModel(name: "Ha", age: 36, imageName: [userImages[2], userImages[0]]),
        SwipeCardModel(name: "An", age: 24, imageName: [userImages[1], userImages[2]]),
        SwipeCardModel(name: "Andrew", age: 21, imageName: [userImages[2], userImages[0]]),
        SwipeCardModel(name: "Vy", age: 18, imageName: [userImages[1], userImages[2]]),
        SwipeCardModel(name: "Ha", age: 36, imageName: [userImages[2], userImages[0]]),
        SwipeCardModel(name: "An", age: 24, imageName: [userImages[1], userImages[2]]),
        SwipeCardModel(name: "Andrew", age: 21, imageName: [userImages[2], userImages[0]])]
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        swipeStackContainer.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (!UserDefaults.standard.isLoggedIn()) {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    // MARK: Setup
    private func setup() {
        self.view.backgroundColor = Constants.Colors.mainBackgroundColor
        addSubViews()
        setupConstraints()
    }
    
    private func addSubViews() {
        view.addSubview(profileButton)
        view.addSubview(messageButton)
        view.addSubview(swipeStackContainer)
        view.addSubview(buttonStack)
        
        buttonStack.addArrangedSubview(dislikeButton)
        buttonStack.addArrangedSubview(likeButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileButton.heightAnchor.constraint(equalToConstant: 60),
            profileButton.widthAnchor.constraint(equalToConstant: 60),
            profileButton.safeAreaLayoutGuide.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            profileButton.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 6)
        ])
        
        NSLayoutConstraint.activate([
            messageButton.heightAnchor.constraint(equalToConstant: 60),
            messageButton.widthAnchor.constraint(equalToConstant: 60),
            messageButton.safeAreaLayoutGuide.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            messageButton.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 6)
        ])
        
        NSLayoutConstraint.activate([
            buttonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStack.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            buttonStack.heightAnchor.constraint(equalToConstant: Constants.PaddingValues.likeButtonHeight)
        ])
        
        NSLayoutConstraint.activate([
            swipeStackContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
            swipeStackContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
            swipeStackContainer.bottomAnchor.constraint(equalTo: buttonStack.topAnchor, constant: -Constants.PaddingValues.likeButtonHeight - 36),
            swipeStackContainer.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 6)
        ])
        NSLayoutConstraint.activate([
            likeButton.heightAnchor.constraint(equalToConstant: Constants.PaddingValues.likeButtonHeight),
            likeButton.widthAnchor.constraint(equalToConstant: Constants.PaddingValues.likeButtonHeight),
        ])
        NSLayoutConstraint.activate([
            dislikeButton.heightAnchor.constraint(equalToConstant: Constants.PaddingValues.likeButtonHeight),
            dislikeButton.widthAnchor.constraint(equalToConstant: Constants.PaddingValues.likeButtonHeight),
        ])
        
    }
    
    @objc func likePressed() {
       
    }
    
    @objc func dislikePressed() {
        
    }
}

extension MainViewController: SwipeableCardDataSource {
    
    func card(forItemAt index: Int) -> SwipeCardView {
            let card = SwipeCardView()
            card.dataSource = users[index]
            return card
    }
    
    func numberOfCards() -> Int {
        return users.count
    }
    
    func viewForEmptyCards() -> UIView? {
        return nil
    }
    
}

