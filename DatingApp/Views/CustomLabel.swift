//
//  CustomLabel.swift
//  DatingApp
//
//  Created by Vy Le on 4/5/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class CustomLabel: UILabel {
    init(text: String, textColor: UIColor) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.textColor = textColor
        self.text = text
        self.textAlignment = .left
        self.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
