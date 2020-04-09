//
//  EditUserDetailsView.swift
//  DatingApp
//
//  Created by Vy Le on 4/7/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class EditUserDetailsView: UIView {
    private let verticalStackView = CustomStackView(axis: .vertical)
    private let horizontalStackView1 = CustomStackView(axis: .horizontal)
    private let horizontalStackView2 = CustomStackView(axis: .horizontal)
    private let addImageButton1 = AddImageButton()
    private let addImageButton2 = AddImageButton()
    private let addImageButton3 = AddImageButton()
    private let addImageButton4 = AddImageButton()
    private let addImageButton5 = AddImageButton()
    private let addImageButton6 = AddImageButton()
    private var featureLabel = SectionTitleLabel(title: "Featured")
    private let bioLabel = SectionTitleLabel(title: "Bio")
    private let detailsLabel = SectionTitleLabel(title: "Details")
    private let bioTextView = InputTextView(placeholder: "Describe Yourself...", cornerRadius: 10, isScrollable: false)
    private let workTextField = CustomTextField()
    private let saveButton = RoundedButton(title: "Save", color: .orange)
    private let logoutButton = RoundedButton(title: "Logout", color: Constants.Colors.orangeRed)
    private let mainProfileImage = CustomImageView(imageName: "Vy.jpg", cornerRadius: 50)
    private let nameLabel = CustomLabel(text: "Unknown", textColor: .darkGray, textSize: 28, textWeight: .heavy)
    
    //MARK: Init
    init() {
        super.init(frame: .zero)
        setUp()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: Setup
    private func setUp() {
        addSubviews()
        setUpConstraints()
    }
    
    private func addSubviews() {
        self.addSubview(verticalStackView)
        self.addSubview(bioLabel)
        self.addSubview(bioTextView)
        self.addSubview(detailsLabel)
        self.addSubview(workTextField)
        self.addSubview(saveButton)
        self.addSubview(logoutButton)
        self.addSubview(mainProfileImage)
        self.addSubview(nameLabel)
        self.addSubview(featureLabel)
        verticalStackView.addArrangedSubview(horizontalStackView1)
        verticalStackView.addArrangedSubview(horizontalStackView2)
        horizontalStackView1.addArrangedSubview(addImageButton1)
        horizontalStackView1.addArrangedSubview(addImageButton2)
        horizontalStackView1.addArrangedSubview(addImageButton3)
        horizontalStackView2.addArrangedSubview(addImageButton4)
        horizontalStackView2.addArrangedSubview(addImageButton5)
        horizontalStackView2.addArrangedSubview(addImageButton6)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            mainProfileImage.safeAreaLayoutGuide.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 12),
            mainProfileImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainProfileImage.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4),
            mainProfileImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4)
        ])
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: mainProfileImage.bottomAnchor, constant: 6),
            nameLabel.centerXAnchor.constraint(equalTo: mainProfileImage.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            bioLabel.safeAreaLayoutGuide.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            bioLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
        ])
        NSLayoutConstraint.activate([
            bioTextView.topAnchor.constraint(equalTo: bioLabel.bottomAnchor),
            bioTextView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            bioTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
        ])
        NSLayoutConstraint.activate([
            detailsLabel.safeAreaLayoutGuide.topAnchor.constraint(equalTo: bioTextView.bottomAnchor, constant: 12),
            detailsLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
        ])
        NSLayoutConstraint.activate([
            workTextField.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor),
            workTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            workTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
        ])
        NSLayoutConstraint.activate([
            featureLabel.topAnchor.constraint(equalTo: workTextField.bottomAnchor, constant: 12),
            featureLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
        ])
        NSLayoutConstraint.activate([
            verticalStackView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: featureLabel.bottomAnchor, constant: 12),
            verticalStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            verticalStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            verticalStackView.heightAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 2/3)
        ])
        NSLayoutConstraint.activate([
            saveButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            saveButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -36),
            saveButton.bottomAnchor.constraint(equalTo: logoutButton.topAnchor, constant: -12),
            saveButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            logoutButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
            logoutButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -36),
            logoutButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -36),
            logoutButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
