//
//  MainViewController.swift
//  DatingApp
//
//  Created by Vy Le on 1/21/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIGestureRecognizerDelegate {
    
    let profileImage = RoundedUserImage(imageName: "Image1.jpg")
    
//    let viewShadow = ViewShadow()
    
    let likeButton: CircleButton = {
        let button = CircleButton(imageName: "heart.jpg")
        button.addTarget(self, action: #selector(likePressed), for: .touchUpInside)
        return button
    }()
    
    let dislikeButton: CircleButton = {
        let button = CircleButton(imageName: "dislike.jpg")
        button.addTarget(self, action: #selector(dislikePressed), for: .touchUpInside)
        return button
    }()
    
    let profileDetails: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    let buttonStack: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .red
        stackView.spacing = 60
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let userImages = ["Vy.jpg", "Image1.jpg", "Image2.jpg"]
    var currentImage = 0
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constants.mainBackgroundColor
        addSubViews()
        setupConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnPicture))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.delegate = self
        profileImage.addGestureRecognizer(tapGesture)
    }
    
    // MARK: Setup
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
            profileImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 36),
            profileImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -36),
            profileImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -180),
            profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            likeButton.heightAnchor.constraint(equalToConstant: 80),
            likeButton.widthAnchor.constraint(equalToConstant: 80),
            
            dislikeButton.heightAnchor.constraint(equalToConstant: 80),
            dislikeButton.widthAnchor.constraint(equalToConstant: 80),
            
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
                    profileImage.image = UIImage(named: userImages[currentImage])
                } else {
                    currentImage = currentImage - 1
                    profileImage.image = UIImage(named: userImages[currentImage])
                }
            } else {
                print("RIGTH")
                if (currentImage == userImages.count - 1) {
                    currentImage = 0
                    profileImage.image = UIImage(named: userImages[currentImage])
                } else {
                    currentImage = currentImage + 1
                    profileImage.image = UIImage(named: userImages[currentImage])
                }
            }
        }
    }
    
    @objc func likePressed() {
       
    }
    
    @objc func dislikePressed() {
       
    }
    
}

