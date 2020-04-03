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
    private var stackContainer = SwipeCardStackContainer()
    
    private let likeButton: CircleButton = {
        let button = CircleButton(imageName: "heart.jpg")
        button.addTarget(self, action: #selector(likePressed), for: .touchUpInside)
        return button
    }()
    
    private let dislikeButton: CircleButton = {
        let button = CircleButton(imageName: "dislike.jpg")
        button.addTarget(self, action: #selector(dislikePressed), for: .touchUpInside)
        return button
    }()
    
    private let buttonStack: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .red
        stackView.spacing = 60
        stackView.alignment = .center
        stackView.distribution = .fillEqually
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
        stackContainer.dataSource = self
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
        view.addSubview(stackContainer)
        view.addSubview(buttonStack)
        buttonStack.addArrangedSubview(dislikeButton)
        buttonStack.addArrangedSubview(likeButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
            stackContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
            stackContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -160),
            stackContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 90)
        ])
        NSLayoutConstraint.activate([
            likeButton.heightAnchor.constraint(equalToConstant: 80),
            likeButton.widthAnchor.constraint(equalToConstant: 80),
        ])
        NSLayoutConstraint.activate([
            dislikeButton.heightAnchor.constraint(equalToConstant: 80),
            dislikeButton.widthAnchor.constraint(equalToConstant: 80),
        ])
        NSLayoutConstraint.activate([
            buttonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            buttonStack.topAnchor.constraint(equalTo: stackContainer.bottomAnchor, constant: 12)
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

