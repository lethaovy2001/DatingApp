//
//  ErrorLabel.swift
//  DatingApp
//
//  Created by Vy Le on 5/18/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class ErrorLabel: CustomLabel {
    init() {
        super.init(text: "Error", textColor: UIColor.red, textSize: 14, textWeight: .regular)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
