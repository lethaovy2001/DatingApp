//
//  InputContainerView.swift
//  DatingApp
//
//  Created by Vy Le on 5/21/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class InputContainerView : CustomContainerView {
    override init() {
        super.init()
        self.backgroundColor = .white
        self.layer.addShadow(withDirection: .top)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
