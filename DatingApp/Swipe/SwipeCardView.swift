//
//  SwipeCardView.swift
//  DatingApp
//
//  Created by Vy Le on 2/2/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class SwipeCardView: UIView {
    
    private var cardImages = ["Vy.jpg", "Image1.jpg", "Image2.jpg"]

    private let cardImageView = RoundedUserImage(imageName: "Vy.jpg")
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .white
        label.text = "First, 18"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 36, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }

    //MARK: Setup
    private func setup() {
        configureViewShadow()
        addSubViews()
        setupConstraints()
    }
    
    private func configureViewShadow() {
        self.backgroundColor = .red
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 5.0
        self.layer.cornerRadius = Constants.swipeImageCornerRadius
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubViews() {
        self.addSubview(cardImageView)
        cardImageView.addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cardImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            cardImageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            cardImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            cardImageView.topAnchor.constraint(equalTo: self.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: cardImageView.leftAnchor, constant: 36),
            nameLabel.rightAnchor.constraint(equalTo: cardImageView.rightAnchor, constant: -36),
            nameLabel.bottomAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: -36)
        ])
    }
    
    private var currentImage = 0
    
    func nextImage(isLeft: Bool) {
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
        cardImageView.image = UIImage(named: cardImages[currentImage])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
