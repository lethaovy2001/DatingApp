//
//  RoundedUserImage.swift
//  DatingApp
//
//  Created by Vy Le on 1/28/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class RoundedUserImage: UIImageView {
    
    init(imageName: String) {
        super.init(image: UIImage(named: imageName))
        self.contentMode = .scaleAspectFill
        self.isUserInteractionEnabled = true
        self.layer.cornerRadius = 40
//        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
//        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
//        self.layer.shadowOpacity = 1.0
//        self.layer.shadowRadius = 5.0
        self.clipsToBounds = false
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

