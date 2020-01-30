//
//  CircleButton.swift
//  DatingApp
//
//  Created by Vy Le on 1/21/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class CircleButton: UIButton {
    
    init(imageName: String) {
        super.init(frame: .zero)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        self.setTitleColor(.white, for: .normal)
        self.setImage(UIImage(named: imageName), for: .normal)
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        self.layer.cornerRadius = 40
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 5.0
        self.layer.masksToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
