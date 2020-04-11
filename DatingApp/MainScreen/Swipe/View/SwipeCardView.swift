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
    private var currentImage = 0
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
    
    var delegate: SwipeCardDelegate?
    var dataSource : SwipeCardModel? {
        didSet {
            guard let name = dataSource?.name else { return }
            guard let age = dataSource?.age else { return }
            guard let image = dataSource?.imageName[0] else { return }
            self.nameLabel.text = "\(name), \(age)"
            cardImageView.image = UIImage(named: image)
        }
    }
    
    // MARK: Initializer
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup
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
    
    private func addGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        self.addGestureRecognizer(panGesture)
    }
    
    // MARK: Gestures
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
    
    @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
        let card = sender.view as! SwipeCardView
        let point = sender.translation(in: self)
        let centerOfParentContainer = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
         card.center = CGPoint(x: centerOfParentContainer.x + point.x, y: centerOfParentContainer.y + point.y)
        switch sender.state {
        case .ended:
        if (card.center.x) > centerOfParentContainer.x + 40 {
             self.delegate?.swipeDidEnd(on: card)
            UIView.animate(withDuration: 0.2) {
                card.center = CGPoint(x: centerOfParentContainer.x + point.x + 400, y: centerOfParentContainer.y + point.y + 75)
                 card.alpha = 0
                 self.layoutIfNeeded()
             }
             return
         } else if card.center.x < centerOfParentContainer.x - 40 {
             delegate?.swipeDidEnd(on: card)
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
    
    private func nextImage(isLeft: Bool) {
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
}
