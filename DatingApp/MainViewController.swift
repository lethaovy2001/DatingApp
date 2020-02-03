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
    
    private let profileDetails: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
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
    private var currentImage = 0
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constants.mainBackgroundColor
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        addSubViews()
        setupConstraints()
        addProfileImageTapGesture()
    }
    
    private func addProfileImageTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnPicture))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.delegate = self
        cardView.addGestureRecognizer(tapGesture)
    }
    
    private func addSubViews() {
        view.addSubview(cardView)
        view.addSubview(buttonStack)
        buttonStack.addArrangedSubview(dislikeButton)
        buttonStack.addArrangedSubview(likeButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cardView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
            cardView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
            cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -160),
            cardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
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
            buttonStack.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 12)
        ])
    }
    
    @objc func tapOnPicture(sender: UITapGestureRecognizer) {
        let bounds = CGPoint(x: cardView.bounds.midX, y: cardView.bounds.midY)
        if sender.state == .ended {
            let position = sender.location(in: self.cardView)
            if (position.x < bounds.x) {
                print("LEFT")
                cardView.nextImage(isLeft: true)
            } else {
                cardView.nextImage(isLeft: false)
            }
        }
    }
    
    @objc func likePressed() {
       
    }
    
    @objc func dislikePressed() {
       
    }
    
}

//extension MainViewController: SwipeableCardDataSource {
//    
//    func card(forItemAt index: Int) -> SwipeCardView {
//            let card = SwipeCardView()
//            //card.dataSource = userImages[index]
//            return card
//
//    }
//    
//    func numberOfCards() -> Int {
//        return userImages.count
//    }
//    
//    func viewForEmptyCards() -> UIView? {
//        return nil
//    }
//    
//    
//}

