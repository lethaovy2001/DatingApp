//
//  PasswordTextField.swift
//  DatingApp
//
//  Created by Vy Le on 5/19/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class PasswordTextField: CustomTextField {
    // MARK: - Initializer
    override init() {
        super.init(placeholder: "Password")
        self.isSecureTextEntry = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
