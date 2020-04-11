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
        view.backgroundColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()
    
    private let profileImageView = CircleImageView(imageName: "Vy")
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "I love you 3000 \n lala"
        tv.font = UIFont.boldSystemFont(ofSize: 16)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // MARK: Setup
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

        containerViewRightAnchor = containerView.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: 60)
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
            textView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            textView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
