//
//  EditUserDetailsView.swift
//  DatingApp
//
//  Created by Vy Le on 4/7/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class EditUserDetailsView: UIView {
    private let horizontalStackView1: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .yellow
        return stackView
    }()
    private let horizontalStackView2: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .yellow
        return stackView
    }()
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .red
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let userImageButton1 = CustomButton(imageName: "plus.circle", size: 20, color: .darkGray, cornerRadius: 10, shadowColor: nil, backgroundColor: Constants.Colors.inputContainerColor)
    private let userImageButton2 = CustomButton(imageName: "plus.circle", size: 20, color: .darkGray, cornerRadius: 10, shadowColor: nil, backgroundColor: Constants.Colors.inputContainerColor)
    private let userImageButton3 = CustomButton(imageName: "plus.circle", size: 20, color: .darkGray, cornerRadius: 10, shadowColor: nil, backgroundColor: Constants.Colors.inputContainerColor)
    private let userImageButton4 = CustomButton(imageName: "plus.circle", size: 20, color: .darkGray, cornerRadius: 10, shadowColor: nil, backgroundColor: Constants.Colors.inputContainerColor)
    private let userImageButton5 = CustomButton(imageName: "plus.circle", size: 20, color: .darkGray, cornerRadius: 10, shadowColor: nil, backgroundColor: Constants.Colors.inputContainerColor)
    private let userImageButton6 = CustomButton(imageName: "plus.circle", size: 20, color: .darkGray, cornerRadius: 10, shadowColor: nil, backgroundColor: Constants.Colors.inputContainerColor)
    private var featureLabel = CustomLabel(text: "Featured", textColor: .orange, textSize: 24, textWeight: .bold)
    private let bioLabel = CustomLabel(text: "Bio", textColor: .orange, textSize: 24, textWeight: .bold)
    private let bioTextView = InputTextView(placeholder: "Describe Yourself...", cornerRadius: 10, isScrollable: false)
    private let detailsLabel = CustomLabel(text: "Details", textColor: .orange, textSize: 24, textWeight: .bold)
    private let workTextField = CustomTextField()
    private let saveButton = RoundedButton(title: "Save", color: .orange)
    private let logoutButton = RoundedButton(title: "Logout", color: Constants.Colors.orangeRed)
    
    init() {
        super.init(frame: .zero)
        setUp()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUp() {
        addSubviews()
        setUpConstraints()
    }
    
    private func addSubviews() {
        self.addSubview(featureLabel)
        self.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(horizontalStackView1)
        verticalStackView.addArrangedSubview(horizontalStackView2)
        horizontalStackView1.addArrangedSubview(userImageButton1)
        horizontalStackView1.addArrangedSubview(userImageButton2)
        horizontalStackView1.addArrangedSubview(userImageButton3)
        horizontalStackView2.addArrangedSubview(userImageButton4)
        horizontalStackView2.addArrangedSubview(userImageButton5)
        horizontalStackView2.addArrangedSubview(userImageButton6)
        self.addSubview(bioLabel)
        self.addSubview(bioTextView)
        self.addSubview(detailsLabel)
        self.addSubview(workTextField)
        self.addSubview(saveButton)
        self.addSubview(logoutButton)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            bioLabel.safeAreaLayoutGuide.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 12),
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
