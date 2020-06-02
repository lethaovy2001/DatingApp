//
//  SwipeCardView.swift
//  DatingApp
//
//  Created by Vy Le on 2/2/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class SwipeCardView : UIView {
    // MARK: Properties
    private var cardImages: [UIImage] = []
    private var currentImage = 0
    private let cardImageView = RoundedUserImage(imageName: "user")
    private let nameLabel = CustomLabel(text: "First Name, Age", textColor: .white, textSize: 36, textWeight: .heavy)
    var delegate: SwipeCardDelegate?
    var dataSource: UserModel? {
        didSet {
            guard let name = dataSource?.name else { return }
            guard let birthday = dataSource?.birthday else { return }
            guard let images = dataSource?.images else { return }
            self.cardImages = images
            if (!cardImages.isEmpty) {
                cardImageView.image = images[0]
            }
            var ageText: String {
                let converter = AgeConverter()
                let age = converter.convertToAge(from: birthday)
                return "\(age)"
            }
            self.nameLabel.text = "\(name), \(ageText)"            
        }
    }
    
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        addSubViews()
        setupConstraints()
        addGestures()
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
    
    // MARK: Gestures
    private func addGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        self.addGestureRecognizer(panGesture)
    }
    
    @objc private func handleTapGesture(sender: UITapGestureRecognizer) {
        let bounds = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        if sender.state == .ended {
            let position = sender.location(in: self)
            if (position.x < bounds.x) {
                self.nextImage(isLeft: true)
            } else {
                self.tappedImage(isOnLeftSide: false)
            }
        }
    }
    
    @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
        guard let card = sender.view as? SwipeCardView else { return }
        let point = sender.translation(in: self)
        let centerOfParentContainer = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        card.center = CGPoint(x: centerOfParentContainer.x + point.x, y: centerOfParentContainer.y + point.y)
        switch sender.state {
        case .ended:
            // swipe right
            if (card.center.x) > centerOfParentContainer.x + 40 {
                self.delegate?.swipeDidEnd(on: card, isMatch: true)
                UIView.animate(withDuration: 0.2) {
                    card.center = CGPoint(x: centerOfParentContainer.x + point.x + 400, y: centerOfParentContainer.y + point.y + 75)
                    card.alpha = 0
                    self.layoutIfNeeded()
                }
                return
            // swipe left
            } else if card.center.x < centerOfParentContainer.x - 40 {
                delegate?.swipeDidEnd(on: card, isMatch: false)
                UIView.animate(withDuration: 0.2) {
                    card.center = CGPoint(x: centerOfParentContainer.x + point.x - 400, y: centerOfParentContainer.y + point.y + 75)
                    card.alpha = 0
                    self.layoutIfNeeded()
                }
                return
            }
            // neither swipe left or right
            UIView.animate(withDuration: 0.2) {
                card.transform = .identity
                card.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
                self.layoutIfNeeded()
            }
        case .changed:
            let rotation = tan(point.x / (self.frame.width * 2.0))
            card.transform = CGAffineTransform(rotationAngle: rotation)
        default:
            break
        }
    }
    
    private func tappedImage(isOnLeftSide: Bool) {
        if cardImages.count < 1 {
            return
        }
        if (isOnLeftSide) {
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
        cardImageView.image = cardImages[currentImage]
    }
}
