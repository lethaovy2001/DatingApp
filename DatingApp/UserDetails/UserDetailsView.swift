//
//  UserDetailsView.swift
//  DatingApp
//
//  Created by Vy Le on 4/5/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class UserDetailsView: UIView {
    private let userImageView = CustomImageView(imageName: "Vy.jpg")
    private let nameLabel = CustomLabel(text: "Unknown", textColor: .darkGray, textSize: 28, textWeight: .bold)
    private let ageLabel = CustomLabel(text: ", 19", textColor: .darkGray, textSize: 28, textWeight: .medium)
    //nameContainerView
    private let nameContainerView = CustomContainerView()
    private let workButton = CustomButton(imageName: "bag", size: 10, color: .lightGray, addShadow: false, cornerRadius: nil)
    private let workLabel = CustomLabel(text: "University of Wisconsin - Madison", textColor: .lightGray, textSize: 16, textWeight: .medium)
    private let locationButton = CustomButton(imageName: "mappin", size: 10, color: .lightGray, addShadow: false, cornerRadius: nil)
    private let locationLabel = CustomLabel(text: "Less than a kilometer away", textColor: .lightGray, textSize: 16, textWeight: .medium)
    //bioContainerView
    private let bioContainerView = CustomContainerView()
    private let bioLabel = CustomLabel(text: "BIO", textColor: .orange, textSize: 18, textWeight: .bold)
    private let bioTextView = CustomTextView(text: "I don’t want a partner in crime.\nI commit all my crimes on my own.\nI would never drag you into that ")
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUp()
        self.backgroundColor = Constants.Colors.mainBackgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup
    private func setUp() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        addSubview(userImageView)
        addSubview(nameContainerView)
        nameContainerView.addSubview(nameLabel)
        nameContainerView.addSubview(ageLabel)
        nameContainerView.addSubview(workButton)
        nameContainerView.addSubview(workLabel)
        nameContainerView.addSubview(locationLabel)
        nameContainerView.addSubview(locationButton)
        
        addSubview(bioContainerView)
        bioContainerView.addSubview(bioLabel)
        bioContainerView.addSubview(bioTextView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            userImageView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            userImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            userImageView.rightAnchor.constraint(equalTo: rightAnchor),
            userImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2)
        ])
        NSLayoutConstraint.activate([
            nameContainerView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 12),
            nameContainerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            nameContainerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            nameContainerView.bottomAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 12)
        ])
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: nameContainerView.leftAnchor, constant: 12),
            nameLabel.topAnchor.constraint(equalTo: nameContainerView.topAnchor, constant: 6),
        ])
        NSLayoutConstraint.activate([
            ageLabel.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            ageLabel.leftAnchor.constraint(equalTo: nameLabel.rightAnchor),
        ])
        NSLayoutConstraint.activate([
            workButton.leftAnchor.constraint(equalTo: nameContainerView.leftAnchor, constant: 12),
            workButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            workButton.widthAnchor.constraint(equalToConstant: 14)
        ])
        NSLayoutConstraint.activate([
            workLabel.bottomAnchor.constraint(equalTo: workButton.bottomAnchor),
            workLabel.leftAnchor.constraint(equalTo: workButton.rightAnchor, constant: 2),
        ])
        NSLayoutConstraint.activate([
            locationButton.leftAnchor.constraint(equalTo: nameContainerView.leftAnchor, constant: 12),
            locationButton.topAnchor.constraint(equalTo: workLabel.bottomAnchor, constant: 6),
            locationButton.widthAnchor.constraint(equalToConstant: 14)
        ])
        NSLayoutConstraint.activate([
            locationLabel.bottomAnchor.constraint(equalTo: locationButton.bottomAnchor),
            locationLabel.leftAnchor.constraint(equalTo: locationButton.rightAnchor, constant: 2),
        ])
        NSLayoutConstraint.activate([
            bioContainerView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: nameContainerView.bottomAnchor, constant: 12),
            bioContainerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            bioContainerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            bioContainerView.bottomAnchor.constraint(equalTo: bioTextView.bottomAnchor, constant: 12)
        ])
        NSLayoutConstraint.activate([
            bioLabel.leftAnchor.constraint(equalTo: bioContainerView.leftAnchor, constant: 12),
            bioLabel.topAnchor.constraint(equalTo: bioContainerView.topAnchor, constant: 6),
        ])
        NSLayoutConstraint.activate([
            bioTextView.topAnchor.constraint(equalTo: bioLabel.bottomAnchor),
            bioTextView.leftAnchor.constraint(equalTo: bioContainerView.leftAnchor, constant: 12),
            bioTextView.rightAnchor.constraint(equalTo: bioContainerView.rightAnchor, constant: -12),
            bioTextView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        
    }
    
    
    
    
}
