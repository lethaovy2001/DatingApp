//
//  BottomButton.swift
//  DatingApp
//
//  Created by Vy Le on 5/20/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class BottomButton: CustomButton {
    // MARK: - Initializer
    init(imageName: String, color: UIColor) {
        super.init(imageName: imageName, size: 25, color: color, cornerRadius: (Constants.PaddingValues.likeButtonHeight/2), shadowColor: UIColor.customLightGray, backgroundColor: .white)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
