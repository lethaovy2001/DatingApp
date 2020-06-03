//
//  CustomActivityIndicatorView.swift
//  DatingApp
//
//  Created by Vy Le on 5/21/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class CustomActivityIndicatorView : UIActivityIndicatorView {
    init() {
        super.init(style: .medium)
        self.color = UIColor.white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.hidesWhenStopped = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
