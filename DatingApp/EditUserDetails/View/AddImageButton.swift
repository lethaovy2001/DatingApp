//
//  AddImageView.swift
//  DatingApp
//
//  Created by Vy Le on 4/8/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class AddImageButton: CustomButton {
    private var isDefaultImage: Bool!
    init() {
        super.init(imageName: "plus.circle", size: 20, color: .darkGray, cornerRadius: 10, shadowColor: nil, backgroundColor: UIColor.inputContainerColor)
        isDefaultImage = false
    }
    
    func setImage(name: String) {
        self.setImage(UIImage(named: name), for: .normal)
        self.layer.cornerRadius = 10
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
    }
    
    func setImage(image: UIImage) {
        self.setImage(image, for: .normal)
        self.layer.cornerRadius = 10
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        isDefaultImage = true
    }
    
    func checkIfHasImage() -> Bool {
        return isDefaultImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
