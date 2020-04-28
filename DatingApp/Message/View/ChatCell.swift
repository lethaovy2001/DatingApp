//
//  ChatCell.swift
//  DatingApp
//
//  Created by Vy Le on 2/23/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class ChatCell: UICollectionViewCell {
    
    //TODO: Create a custom class for container
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.amour
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()
    private let profileImageView = CircleImageView(imageName: "Vy")
    private let textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.boldSystemFont(ofSize: Constants.textSize)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = UIColor.clear
        tv.textColor = UIColor.white
        tv.isEditable = false
        tv.isScrollEnabled = false
        return tv
    }()
    private var messageImageView = CustomImageView(imageName: "Vy.jpg", cornerRadius: 16)
    private var containerViewWidthAnchor: NSLayoutConstraint!
    private var containerViewRightAnchor: NSLayoutConstraint!
    private var containerViewLeftAnchor: NSLayoutConstraint!
    var tapDelegate: ZoomTapDelegate?
    var viewModel: MessageViewModel! {
        didSet {
            textView.text = viewModel.text
            setUpMessageRelationshipStyle()
            setUpMessageType()
            if let image = viewModel.image {
                messageImageView.setImage(image: image)
            }
        }
    }
    
    // MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup
    private func setup() {
        addSubviews()
        setupConstraints()
        addTapGesture()
    }
    
    private func addSubviews() {
        addSubview(containerView)
        addSubview(textView)
        addSubview(messageImageView)
        addSubview(profileImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 32),
            profileImageView.heightAnchor.constraint(equalToConstant: 32)
        ])
        containerViewRightAnchor = containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)
        containerViewLeftAnchor = containerView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8)
        containerViewWidthAnchor = containerView.widthAnchor.constraint(equalToConstant: 200)
        containerViewWidthAnchor.isActive = true
        NSLayoutConstraint.activate([
            containerViewRightAnchor,
            containerViewLeftAnchor,
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
        NSLayoutConstraint.activate([
            textView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8),
            textView.topAnchor.constraint(equalTo: self.topAnchor),
            textView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8),
            textView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
        NSLayoutConstraint.activate([
            messageImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            messageImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            messageImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            messageImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.cancelsTouchesInView = false
        messageImageView.isUserInteractionEnabled = true
        messageImageView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func handleTapGesture() {
        tapDelegate?.didTap(on: messageImageView)
    }
    
    private func setUpMessageRelationshipStyle() {
        switch viewModel.style {
        case .currentUser:
            containerView.backgroundColor = UIColor.amour
            textView.textColor = UIColor.white
            containerViewRightAnchor.isActive = true
            containerViewLeftAnchor.isActive = false
            profileImageView.isHidden = true
        case .otherPerson:
            containerView.backgroundColor = UIColor.inputContainerColor
            textView.textColor = UIColor.black
            containerViewRightAnchor.isActive = false
            containerViewLeftAnchor.isActive = true
            profileImageView.isHidden = false
        }
    }
    
    private func setUpMessageType() {
        switch viewModel.messageType {
        case .text:
            containerViewWidthAnchor.constant = textView.estimatedFrameForText(text: viewModel.text).width + 36
            textView.isHidden = false
            messageImageView.isHidden = true
        case .image:
            containerViewWidthAnchor.constant = 200
            textView.isHidden = true
            messageImageView.isHidden = false
        }
    }
    
    
}
