//
//  HeaderButton.swift
//  DatingApp
//
//  Created by Vy Le on 5/20/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class HeaderButton: CustomButton {
    // MARK: - Initializer
    init(imageName: String) {
        super.init(imageName: imageName, size: 25, color: UIColor.customLightGray, cornerRadius: nil, shadowColor: nil, backgroundColor: .clear)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
