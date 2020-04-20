//
//  CustomContainerView.swift
//  DatingApp
//
//  Created by Vy Le on 4/5/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class CustomContainerView: UIView {
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.addShadow(color: UIColor.lightGray)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
