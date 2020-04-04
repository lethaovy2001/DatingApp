//
//  RoundedButton.swift
//  DatingApp
//
//  Created by Vy Le on 1/20/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    init(title: String, color: UIColor) {
        super.init(frame: .zero)
        self.backgroundColor = color
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


