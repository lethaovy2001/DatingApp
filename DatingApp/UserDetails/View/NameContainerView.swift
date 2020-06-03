//
//  NameContainerView.swift
//  DatingApp
//
//  Created by Vy Le on 4/18/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class NameContainerView : CustomContainerView {
    // MARK: - Properties
    private var nameLabel = CustomLabel(text: "First Name", textColor: .darkGray, textSize: 28, textWeight: .bold)
    private let ageLabel = CustomLabel(text: ", Age", textColor: .darkGray, textSize: 28, textWeight: .medium)
    private let workButton = CustomButton(imageName: "bag", size: 10, color: .lightGray, cornerRadius: nil, shadowColor: nil, backgroundColor: .clear)
    private let workLabel = CustomLabel(text: "Unknown workplace", textColor: .lightGray, textSize: 16, textWeight: .medium)
    private let locationButton = CustomButton(imageName: "mappin", size: 10, color: .lightGray, cornerRadius: nil, shadowColor: nil, backgroundColor: .clear)
    private let locationLabel = CustomLabel(text: "Less than a kilometer away", textColor: .lightGray, textSize: 16, textWeight: .medium)
    var viewModel: UserDetailsViewModel! {
        didSet {
            nameLabel.setText(text: viewModel.name)
            ageLabel.setText(text: ", \(viewModel.ageText)")
            workLabel.setText(text: viewModel.work)
        }
    }
    
    // MARK: - Initializer
    override init() {
        super.init(cornerRadius: 6)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        addSubviews()
        setupConstraints()
        setAccessibilityIdentifier()
    }
    
    private func addSubviews() {
        addSubview(nameLabel)
        addSubview(ageLabel)
        addSubview(workButton)
        addSubview(workLabel)
    }
    
    private func setAccessibilityIdentifier() {
        nameLabel.accessibilityIdentifier = "profileName"
        ageLabel.accessibilityIdentifier = "profileAge"
        workLabel.accessibilityIdentifier = "profileWork"
        workButton.accessibilityIdentifier = "workButton"
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
        ])
        NSLayoutConstraint.activate([
            ageLabel.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            ageLabel.leftAnchor.constraint(equalTo: nameLabel.rightAnchor),
        ])
        NSLayoutConstraint.activate([
            workButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            workButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            workButton.widthAnchor.constraint(equalToConstant: 14)
        ])
        NSLayoutConstraint.activate([
            workLabel.bottomAnchor.constraint(equalTo: workButton.bottomAnchor),
            workLabel.leftAnchor.constraint(equalTo: workButton.rightAnchor, constant: 2),
        ])
    }
    
    // MARK: Actions
    func displayLocation() {
        addSubview(locationButton)
        addSubview(locationLabel)
        NSLayoutConstraint.activate([
            locationButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            locationButton.topAnchor.constraint(equalTo: workLabel.bottomAnchor, constant: 6),
            locationButton.widthAnchor.constraint(equalToConstant: 14)
        ])
        NSLayoutConstraint.activate([
            locationLabel.bottomAnchor.constraint(equalTo: locationButton.bottomAnchor),
            locationLabel.leftAnchor.constraint(equalTo: locationButton.rightAnchor, constant: 2),
        ])
    }
}
