//
//  CustomNavigationView.swift
//  DatingApp
//
//  Created by Vy Le on 4/18/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class CustomNavigationView: CustomContainerView {
    private var titleLabel: CustomLabel!
    private var leftButton: CustomButton!
    private var rightButton: CustomButton!
    private var type: NavigationType!
    
    enum NavigationType {
        case userDetails
        case editUserDetails
    }
    
    // MARK: Initializer
    init(type: NavigationType) {
        super.init()
        self.type = type
        self.addShadow(color: UIColor.lightGray, radius: 3.0)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setup() {
        switch type {
        case .userDetails:
            setupLeftButton(imageName: "chevron.left")
            setupRightButton(imageName: "pencil")
            setupTitleLabel(title: "Profile")
        case .editUserDetails:
            setupLeftButton(imageName: "chevron.left")
            setupTitleLabel(title: "Edit")
        default:
            setupLeftButton(imageName: "chevron.left")
        }
    }
    
    private func setupLeftButton(imageName: String) {
        leftButton = CustomButton(imageName: imageName, size: 22, color: UIColor.orangeRed, cornerRadius: nil, shadowColor: nil, backgroundColor: .clear)
        self.addSubview(leftButton)
        NSLayoutConstraint.activate([
            leftButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            leftButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
    
    private func setupRightButton(imageName: String) {
        rightButton = CustomButton(imageName: imageName, size: 22, color: UIColor.orangeRed, cornerRadius: nil, shadowColor: nil, backgroundColor: .clear)
        self.addSubview(rightButton)
        NSLayoutConstraint.activate([
            rightButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            rightButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
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
    
    func setleftButtonSelector(selector: Selector, target: UIViewController) {
        leftButton.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func setRightButtonSelector(selector: Selector, target: UIViewController) {
        rightButton.addTarget(target, action: selector, for: .touchUpInside)
    }
}
