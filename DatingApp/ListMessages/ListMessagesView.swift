//
//  ListMessagesView.swift
//  DatingApp
//
//  Created by Vy Le on 4/14/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class ListMessagesView: UIView {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private let customNavigationView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    private let chatLabel = CustomLabel(text: "Chats", textColor: .darkGray, textSize: 30, textWeight: .heavy)
    private let backButton = CustomButton(imageName: "chevron.left", size: 22, color: Constants.Colors.orangeRed, cornerRadius: nil, shadowColor: nil, backgroundColor: .clear)
    private let profileImageView = CircleImageView(imageName: "Vy")
    var tapDelegate: TapGestureDelegate?
    
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
        addSubviews()
        setupConstraints()
        addTapGesture()
    }
    
    private func addSubviews() {
        self.addSubview(customNavigationView)
        customNavigationView.addSubview(chatLabel)
        customNavigationView.addSubview(profileImageView)
        customNavigationView.addSubview(backButton)
        self.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
           customNavigationView.topAnchor.constraint(equalTo: self.topAnchor),
           customNavigationView.leftAnchor.constraint(equalTo: self.leftAnchor),
           customNavigationView.rightAnchor.constraint(equalTo: self.rightAnchor),
           customNavigationView.heightAnchor.constraint(equalToConstant: 80)
        ])
        NSLayoutConstraint.activate([
            chatLabel.centerXAnchor.constraint(equalTo: customNavigationView.centerXAnchor),
            chatLabel.centerYAnchor.constraint(equalTo: customNavigationView.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            backButton.leftAnchor.constraint(equalTo: customNavigationView.leftAnchor, constant: 16),
            backButton.centerYAnchor.constraint(equalTo: customNavigationView.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
          tableView.topAnchor.constraint(equalTo: customNavigationView.bottomAnchor),
          tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
          tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
          tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            profileImageView.rightAnchor.constraint(equalTo: customNavigationView.rightAnchor, constant: -16),
            profileImageView.centerYAnchor.constraint(equalTo: customNavigationView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
               tapGesture.numberOfTapsRequired = 1
               tapGesture.numberOfTouchesRequired = 1
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTapGesture() {
        tapDelegate?.didTap()
    }
    
    func setBackButtonSelector(selector: Selector, target: UIViewController) {
        backButton.addTarget(target, action: selector, for: .touchUpInside)
    }
}

