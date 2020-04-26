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
        tv.font = UIFont.boldSystemFont(ofSize: 20)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = UIColor.clear
        tv.textColor = UIColor.white
        tv.isEditable = false
        tv.isScrollEnabled = false
        return tv
    }()
    private var containerViewWidthAnchor: NSLayoutConstraint!
    private var containerViewRightAnchor: NSLayoutConstraint!
    private var containerViewLeftAnchor: NSLayoutConstraint!
    var viewModel: MessageViewModel! {
        didSet {
            textView.text = viewModel.text
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
    }
    
    private func addSubviews() {
        addSubview(containerView)
        addSubview(textView)
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
    }
}
