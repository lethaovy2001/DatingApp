//
//  ViewShadow.swift
//  DatingApp
//
//  Created by Vy Le on 1/28/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class ViewShadow: UIView {
    init() {
        super.init(frame: .zero)
//        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
//        self.layer.cornerRadius = 40
//        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
//        self.layer.shadowOpacity = 1.0
//        self.layer.shadowRadius = 5.0
        
        self.backgroundColor = .clear
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 4.0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

