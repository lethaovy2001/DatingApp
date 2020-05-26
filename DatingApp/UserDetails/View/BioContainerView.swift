//
//  BioContainerView.swift
//  DatingApp
//
//  Created by Vy Le on 4/18/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class BioContainerView : CustomContainerView {
    // MARK: - Properties
    private let bioLabel = SectionTitleLabel(title: "Bio")
    private let bioTextView = CustomTextView(text: "No bio")
    var viewModel: UserDetailsViewModel! {
        didSet {
            bioTextView.setText(text: viewModel.bio)
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
        addSubview(bioLabel)
        addSubview(bioTextView)
    }
    
    private func setAccessibilityIdentifier() {
        bioLabel.accessibilityIdentifier = "Bio"
        bioTextView.accessibilityIdentifier = "bioTextView"
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bioLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            bioLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
        ])
        NSLayoutConstraint.activate([
            bioTextView.topAnchor.constraint(equalTo: bioLabel.bottomAnchor),
            bioTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            bioTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            bioTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
