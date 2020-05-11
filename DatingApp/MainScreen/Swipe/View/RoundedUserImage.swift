//
//  RoundedUserImage.swift
//  DatingApp
//
//  Created by Vy Le on 1/28/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class RoundedUserImage: UIImageView {
    
    init(imageName: String?) {
        super.init(image: UIImage(named: imageName ?? ""))
        self.contentMode = .scaleAspectFill
        self.isUserInteractionEnabled = true
        self.layer.cornerRadius = Constants.PaddingValues.swipeImageCornerRadius
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

