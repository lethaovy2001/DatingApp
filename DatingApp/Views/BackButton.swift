//
//  BackButton.swift
//  DatingApp
//
//  Created by Vy Le on 5/17/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class BackButton: CustomButton {
    // MARK: - Initializer
    init() {
        super.init(imageName: Constants.IconNames.back, size: 22, color: UIColor.amour, cornerRadius: nil, shadowColor: nil, backgroundColor: .clear)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
