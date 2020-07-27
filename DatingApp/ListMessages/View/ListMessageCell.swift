//
//  MessageListCell.swift
//  DatingApp
//
//  Created by Vy Le on 4/14/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class ListMessageCell : UITableViewCell {
    // MARK: - Properties
    let profileImageView = CircleImageView(imageName: "user")
    let nameLabel = CustomLabel(text: "Name", textColor: .black, textSize: 20, textWeight: .bold)
    let chatLabel = CustomLabel(text: "Chat", textColor: .black, textSize: 18, textWeight: .regular)
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setup()
        setAccessibilityIdentifier()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    private func setup() {
        addSubviews()
        setConstraints()
    }
    
    private func addSubviews() {
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(chatLabel)
    }
    
    private func setAccessibilityIdentifier() {
        nameLabel.accessibilityIdentifier = "nameLabel"
        chatLabel.accessibilityIdentifier = "chatLabel"
        profileImageView.accessibilityIdentifier = "profileImageView"
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 60),
            profileImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12),
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -12)
        ])
        NSLayoutConstraint.activate([
            chatLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12),
            chatLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 12)
        ])
    }
}
