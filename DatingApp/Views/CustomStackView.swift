//
//  CustomStackView.swift
//  DatingApp
//
//  Created by Vy Le on 4/7/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class CustomStackView: UIStackView {
    init(axis: NSLayoutConstraint.Axis) {
        super.init(frame: .zero)
        self.axis = axis
        self.backgroundColor = .red
        self.distribution = .fillEqually
        self.spacing = 10
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
