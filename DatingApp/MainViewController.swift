//
//  MainViewController.swift
//  DatingApp
//
//  Created by Vy Le on 1/21/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //private let profileImage = RoundedUserImage(imageName: "Image1.jpg")
    
//    let viewShadow = ViewShadow()
    
    private let profileImage = SwipeCardView()
    
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
        profileImage.addGestureRecognizer(tapGesture)
    }
    
    private func addSubViews() {
        view.addSubview(profileImage)
        view.addSubview(buttonStack)
        buttonStack.addArrangedSubview(dislikeButton)
        buttonStack.addArrangedSubview(likeButton)
        
//        viewShadow.addSubview(profileImage)
//        view.bringSubviewToFront(profileImage)
//        view.addSubview(viewShadow)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
            profileImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
            profileImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -160),
            profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
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
            buttonStack.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 12)
        ])
    }
    
    @objc func tapOnPicture(sender: UITapGestureRecognizer) {
        let bounds = CGPoint(x: profileImage.bounds.midX, y: profileImage.bounds.midY)
        if sender.state == .ended {
            let position = sender.location(in: self.profileImage)
            if (position.x < bounds.x) {
                print("LEFT")
                if (currentImage <= 0) {
                    currentImage = userImages.count - 1
//                    profileImage.image = UIImage(named: userImages[currentImage])
                } else {
                    currentImage = currentImage - 1
//                    profileImage.image = UIImage(named: userImages[currentImage])
                }
            } else {
                print("RIGTH")
                if (currentImage == userImages.count - 1) {
                    currentImage = 0
//                    profileImage.image = UIImage(named: userImages[currentImage])
                } else {
                    currentImage = currentImage + 1
//                    profileImage.image = UIImage(named: userImages[currentImage])
                }
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

