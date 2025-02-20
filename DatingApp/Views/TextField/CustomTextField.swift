//
//  CustomTextField.swift
//  DatingApp
//
//  Created by Vy Le on 4/7/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    private let padding = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.inputContainerColor
        self.placeholder = "Where do you work?"
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
    }
    
    init(placeholder: String) {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.inputContainerColor
        self.placeholder = placeholder
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
    }
    
    init(placeholder: String, keyboardType: UIKeyboardType) {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.inputContainerColor
        self.placeholder = placeholder
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
        self.keyboardType = keyboardType
    }
    
    func setText(text: String) {
        self.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.inset(by: padding)
    }
}
