//
//  UIView+helpers.swift
//  DatingApp
//
//  Created by Vy Le on 4/3/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

extension UIView {
    func addShadow(withDirection direction: shadowDirection) {
        switch direction {
        case .top:
            addShadow(offsetHeight: -10.0, offsetWidth: 0.0, shadowRadius: 6.0)
        case .bottom:
            addShadow(offsetHeight: 3.0, offsetWidth: 0.0, shadowRadius: 5.0)
        }
    }
    
    private func addShadow(offsetHeight: CGFloat, offsetWidth: CGFloat, shadowRadius: CGFloat) {
        self.layer.shadowColor = Constants.Colors.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: offsetWidth, height: offsetHeight)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = shadowRadius
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = false
    }
}

enum shadowDirection {
    case top
    case bottom
}
