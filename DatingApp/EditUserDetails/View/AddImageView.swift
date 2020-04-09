//
//  AddImageView.swift
//  DatingApp
//
//  Created by Vy Le on 4/8/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class AddImageButton: CustomButton {
    init() {
        super.init(imageName: "plus.circle", size: 20, color: .darkGray, cornerRadius: 10, shadowColor: nil, backgroundColor: Constants.Colors.inputContainerColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
