//
//  CustomContainerView.swift
//  DatingApp
//
//  Created by Vy Le on 4/5/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class CustomContainerView: UIView {

    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(cornerRadius: CGFloat) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.addShadow(color: UIColor.customLightGray)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = cornerRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
