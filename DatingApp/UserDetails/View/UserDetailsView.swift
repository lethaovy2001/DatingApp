//
//  UserDetailsView.swift
//  DatingApp
//
//  Created by Vy Le on 4/5/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class UserDetailsView: UIView {
    private let userImageView = CustomImageView(imageName: "Vy.jpg", cornerRadius: 10)
    private let nameContainerView = NameContainerView()
    private let bioContainerView = BioContainerView()
    private let scrollView = CustomScrollView()
    private var cardImages: [String]?
    private var currentImage = 0
    private let customNavigationView = CustomNavigationView(type: .userDetails)
//    private let profileLabel = CustomLabel(text: "Profile", textColor: .darkGray, textSize: 30, textWeight: .heavy)
//    private let backButton = CustomButton(imageName: "chevron.left", size: 22, color: Constants.Colors.orangeRed, cornerRadius: nil, shadowColor: nil, backgroundColor: .clear)
//    private let editButton = CustomButton(imageName: "pencil", size: 22, color: Constants.Colors.orangeRed, cornerRadius: nil, shadowColor: nil, backgroundColor: .clear)
    var viewModel: UserDetailsViewModel! {
        didSet {
            nameContainerView.viewModel = viewModel
            bioContainerView.viewModel = viewModel
            //            userImageView.setName(name: viewModel.mainImageName)
            //            cardImages = viewModel.images
        }
    }
    init() {
        super.init(frame: .zero)
        setUp()
        self.backgroundColor = UIColor.mainBackgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setUp() {
        addSubviews()
        setupConstraints()
        addGestures()
    }
    
    private func addSubviews() {
        addSubview(customNavigationView)
        addSubview(scrollView)
        scrollView.addSubview(userImageView)
        scrollView.addSubview(nameContainerView)
        scrollView.addSubview(bioContainerView)
        bringSubviewToFront(customNavigationView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            customNavigationView.topAnchor.constraint(equalTo: self.topAnchor),
            customNavigationView.leftAnchor.constraint(equalTo: self.leftAnchor),
            customNavigationView.rightAnchor.constraint(equalTo: self.rightAnchor),
            customNavigationView.heightAnchor.constraint(equalToConstant: 100),
        ])
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 12),
            userImageView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 12),
            userImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            userImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.75/3)
        ])
        NSLayoutConstraint.activate([
            nameContainerView.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 12),
            nameContainerView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 12),
            nameContainerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            nameContainerView.heightAnchor.constraint(equalToConstant: 120)
        ])
        NSLayoutConstraint.activate([
            bioContainerView.topAnchor.constraint(equalTo: nameContainerView.bottomAnchor, constant: 12),
            bioContainerView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 12),
            bioContainerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            bioContainerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 12)
        ])
    }
    
    func setEditSelector(selector: Selector, target: UIViewController) {
        customNavigationView.setRightButtonSelector(selector: selector, target: target)
    }
    
    func setBackButtonSelector(selector: Selector, target: UIViewController) {
        customNavigationView.setleftButtonSelector(selector: selector, target: target)
    }
    
    // MARK: Gestures
    private func addGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        userImageView.isUserInteractionEnabled = true
        userImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTapGesture(sender: UITapGestureRecognizer) {
        let bounds = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        if sender.state == .ended {
            let position = sender.location(in: self)
            if (position.x < bounds.x) {
                self.nextImage(isLeft: true)
            } else {
                self.nextImage(isLeft: false)
            }
        }
    }
    
    private func nextImage(isLeft: Bool) {
        if let cardImages = cardImages {
            if (isLeft) {
                if (currentImage <= 0) {
                    currentImage = cardImages.count - 1
                } else {
                    currentImage = currentImage - 1
                }
            } else {
                if (currentImage == cardImages.count - 1) {
                    currentImage = 0
                } else {
                    currentImage = currentImage + 1
                }
            }
            userImageView.image = UIImage(named: cardImages[currentImage])
        }
    }
}
