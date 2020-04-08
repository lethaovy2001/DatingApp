//
//  UserDetailsView.swift
//  DatingApp
//
//  Created by Vy Le on 4/5/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class UserDetailsView: UIView {
    private let userImageView = CustomImageView(imageName: "Vy.jpg", cornerRadius: 10)
    private let nameLabel = CustomLabel(text: "Unknown", textColor: .darkGray, textSize: 28, textWeight: .bold)
    private let ageLabel = CustomLabel(text: ", 19", textColor: .darkGray, textSize: 28, textWeight: .medium)
    private let nameContainerView = CustomContainerView()
    private let workButton = CustomButton(imageName: "bag", size: 10, color: .lightGray, cornerRadius: nil, shadowColor: nil, backgroundColor: .clear)
    private let workLabel = CustomLabel(text: "University of Wisconsin - Madison", textColor: .lightGray, textSize: 16, textWeight: .medium)
    private let locationButton = CustomButton(imageName: "mappin", size: 10, color: .lightGray, cornerRadius: nil, shadowColor: nil, backgroundColor: .clear)
    private let locationLabel = CustomLabel(text: "Less than a kilometer away", textColor: .lightGray, textSize: 16, textWeight: .medium)
    private let bioContainerView = CustomContainerView()
    private let bioLabel = CustomLabel(text: "BIO", textColor: .orange, textSize: 18, textWeight: .bold)
    private let bioTextView = CustomTextView(text: "I don’t want a partner in crime. I commit all my crimes on my own.\nI would never drag you into that \nI don’t want a partner in crime.\nI commit all my crimes on my own.\nI would never drag you into that\nI would never drag you into that \nI don’t want a partner in crime.\nI commit all my crimes on my own.\nI would never drag you into that ")
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    private let editButton = CustomButton(imageName: "pencil.circle.fill", size: 100, color: .orange, cornerRadius: 50, shadowColor: UIColor.lightGray, backgroundColor: .white)
    
    init() {
        super.init(frame: .zero)
        setUp()
        self.backgroundColor = Constants.Colors.mainBackgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
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
        addSubview(scrollView)
        scrollView.addSubview(userImageView)
        scrollView.addSubview(nameContainerView)
        nameContainerView.addSubview(nameLabel)
        nameContainerView.addSubview(ageLabel)
        nameContainerView.addSubview(workButton)
        nameContainerView.addSubview(workLabel)
        nameContainerView.addSubview(locationLabel)
        nameContainerView.addSubview(locationButton)
        scrollView.addSubview(bioContainerView)
        bioContainerView.addSubview(bioLabel)
        bioContainerView.addSubview(bioTextView)
        addSubview(editButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 12),
            userImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            userImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            userImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.75/3)
        ])
        NSLayoutConstraint.activate([
            nameContainerView.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 12),
            nameContainerView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 12),
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
            bioContainerView.topAnchor.constraint(equalTo: nameContainerView.bottomAnchor, constant: 12),
            bioContainerView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 12),
            bioContainerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            bioContainerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 12)
        ])
        NSLayoutConstraint.activate([
            bioLabel.leftAnchor.constraint(equalTo: bioContainerView.leftAnchor, constant: 12),
            bioLabel.topAnchor.constraint(equalTo: bioContainerView.topAnchor, constant: 6),
        ])
        NSLayoutConstraint.activate([
            bioTextView.topAnchor.constraint(equalTo: bioLabel.bottomAnchor),
            bioTextView.leftAnchor.constraint(equalTo: bioContainerView.leftAnchor, constant: 12),
            bioTextView.rightAnchor.constraint(equalTo: bioContainerView.rightAnchor, constant: -12),
            bioTextView.bottomAnchor.constraint(equalTo: bioContainerView.bottomAnchor, constant: -12)
        ])
        NSLayoutConstraint.activate([
            editButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -36),
            editButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24),
            editButton.heightAnchor.constraint(equalToConstant: 60),
            editButton.widthAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    func setEditSelector(selector: Selector, target: UIViewController) {
        editButton.addTarget(target, action: selector, for: .touchUpInside)
    }
}
