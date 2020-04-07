//
//  UIView+helpers.swift
//  DatingApp
//
//  Created by Vy Le on 4/3/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

extension UIView {
    func addShadow(color: UIColor) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 5.0
        self.layer.masksToBounds = false
       
    }
}
