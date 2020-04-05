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
    private let customLabel = CustomLabel(text: "Unknown", textColor: .darkGray)
    
    private let view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUp()
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
        addSubview(customLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            userImageView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            userImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            userImageView.rightAnchor.constraint(equalTo: rightAnchor),
            userImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2)
        ])
        NSLayoutConstraint.activate([
            customLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            customLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 6),
        ])
    }
    
    
    
    
}
