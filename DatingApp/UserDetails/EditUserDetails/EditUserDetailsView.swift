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
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .yellow
        return stackView
    }()
    private let horizontalStackView2: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .yellow
        return stackView
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .red
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let image1 = CustomButton(imageName: "plus.circle", size: 20, color: .darkGray, cornerRadius: nil, shadowColor: .darkGray)
    private let image2 = CustomButton(imageName: "plus.circle", size: 20, color: .darkGray, cornerRadius: nil, shadowColor: .darkGray)
    private let image3 = CustomButton(imageName: "plus.circle", size: 20, color: .darkGray, cornerRadius: nil, shadowColor: .darkGray)
    private let image4 = CustomButton(imageName: "plus.circle", size: 20, color: .darkGray, cornerRadius: nil, shadowColor: .darkGray)
    private let image5 = CustomButton(imageName: "plus.circle", size: 20, color: .darkGray, cornerRadius: nil, shadowColor: .darkGray)
    private let image6 = CustomButton(imageName: "plus.circle", size: 20, color: .darkGray, cornerRadius: nil, shadowColor: .darkGray)
    
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
        self.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(horizontalStackView1)
        verticalStackView.addArrangedSubview(horizontalStackView2)
        horizontalStackView1.addArrangedSubview(image1)
        horizontalStackView1.addArrangedSubview(image2)
        horizontalStackView1.addArrangedSubview(image3)
        horizontalStackView2.addArrangedSubview(image4)
        horizontalStackView2.addArrangedSubview(image5)
        horizontalStackView2.addArrangedSubview(image6)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            verticalStackView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 12),
            verticalStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            verticalStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
            verticalStackView.heightAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 2/3)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
