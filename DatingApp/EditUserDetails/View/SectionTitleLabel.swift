//
//  SectionTitleLabel.swift
//  DatingApp
//
//  Created by Vy Le on 4/8/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class SectionTitleLabel: CustomLabel {
    init(title: String) {
        super.init(text: title, textColor: .orange, textSize: 24, textWeight: .bold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
