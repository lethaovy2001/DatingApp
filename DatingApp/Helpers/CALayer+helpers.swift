//
//  UIView+helpers.swift
//  DatingApp
//
//  Created by Vy Le on 4/3/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
extension CALayer {
    func addShadow(withDirection direction: shadowDirection) {
        switch direction {
        case .top:
            addShadow(offsetHeight: -10.0, offsetWidth: 0.0, shadowRadius: 6.0)
        case .bottom:
            addShadow(offsetHeight: 3.0, offsetWidth: 0.0, shadowRadius: 5.0)
        }
    }

    private func addShadow(offsetHeight: CGFloat, offsetWidth: CGFloat, shadowRadius: CGFloat) {
        self.shadowColor = Constants.Colors.lightGray.cgColor
        self.shadowOffset = CGSize(width: offsetWidth, height: offsetHeight)
        self.shadowOpacity = 1.0
        self.shadowRadius = shadowRadius
        self.borderColor = UIColor.clear.cgColor
        self.masksToBounds = false
    }
}

enum shadowDirection {
    case top
    case bottom
}
