//
//  CircleImageView.swift
//  DatingApp
//
//  Created by Vy Le on 4/4/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class CircleImageView: UIImageView {
    init(cornerRadius: CGFloat, imageName: String) {
        super.init(image: UIImage(named: imageName))
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.contentMode = .scaleAspectFill
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

