//
//  CustomNavigationView.swift
//  DatingApp
//
//  Created by Vy Le on 4/18/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class CustomNavigationView: CustomContainerView {
    // MARK: - Properties
    private var titleLabel: CustomLabel!
    private var leftButton: CustomButton!
    private var rightButton: CustomButton!
    private var type: NavigationType!
    private var profileImageView: CircleImageView!
    var tapDelegate: ImageTapGestureDelegate?
    
    enum NavigationType {
        case userDetails
        case editUserDetails
        case listMessages
        case chatMessage
    }
    
    // MARK: - Initializer
    init(type: NavigationType) {
        super.init(cornerRadius: 0)
        self.type = type
        self.addShadow(color: UIColor.customLightGray, radius: 3.0)
        setup()
        addTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        switch type {
        case .userDetails:
            setupLeftButton(imageName: "chevron.left")
            setupRightButton(symbolName: "pencil")
            setupTitleLabel(title: "Profile")
        case .editUserDetails:
            setupLeftButton(imageName: "chevron.left")
            setupTitleLabel(title: "Edit")
        case .chatMessage:
            setupLeftButton(imageName: "chevron.left")
            setupTitleLabel(title: "")
        case .listMessages:
            setupLeftButton(imageName: "chevron.left")
            setupRightButton(imageName: "user")
            setupTitleLabel(title: "Chats")
        default:
            setupLeftButton(imageName: "chevron.left")
        }
    }
    
    private func setupLeftButton(imageName: String) {
        leftButton = CustomButton(imageName: imageName, size: 22, color: UIColor.amour, cornerRadius: nil, shadowColor: nil, backgroundColor: .clear)
        self.addSubview(leftButton)
        NSLayoutConstraint.activate([
            leftButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            leftButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
    
    private func setupRightButton(symbolName: String) {
        rightButton = CustomButton(imageName: symbolName, size: 22, color: UIColor.amour, cornerRadius: nil, shadowColor: nil, backgroundColor: .clear)
        self.addSubview(rightButton)
        NSLayoutConstraint.activate([
            rightButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            rightButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
    
    private func setupRightButton(imageName: String) {
        profileImageView = CircleImageView(imageName: imageName)
        self.addSubview(profileImageView)
        NSLayoutConstraint.activate([
            profileImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupTitleLabel(title: String) {
        titleLabel = CustomLabel(text: title, textColor: .darkGray, textSize: 30, textWeight: .heavy)
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        switch type {
        case .chatMessage:
            titleLabel.isUserInteractionEnabled = true
            titleLabel.addGestureRecognizer(tapGesture)
        case .listMessages:
            profileImageView.isUserInteractionEnabled = true
            profileImageView.addGestureRecognizer(tapGesture)
        default:
            break
        }
    }
    
    // MARK: Selectors
    func setleftButtonSelector(selector: Selector, target: UIViewController) {
        leftButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func setRightButtonSelector(selector: Selector, target: UIViewController) {
        rightButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    // MARK: Actions
    @objc private func handleTapGesture() {
        tapDelegate?.didTap()
    }
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    func hideEditButton() {
        rightButton.isHidden = true
    }
}
