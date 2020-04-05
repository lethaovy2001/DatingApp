//
//  CustomImageView.swift
//  DatingApp
//
//  Created by Vy Le on 4/5/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    
    init(imageName: String) {
        super.init(frame: .zero)
        self.image = UIImage(named: imageName)
        self.contentMode = .scaleAspectFill
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
