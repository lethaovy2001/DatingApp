//
//  CustomButton.swift
//  DatingApp
//
//  Created by Vy Le on 1/21/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    init(imageName: String, size: CGFloat, color: UIColor, cornerRadius: CGFloat?, shadowColor: UIColor?, backgroundColor: UIColor) {
        super.init(frame: .zero)
        let configuration = UIImage.SymbolConfiguration(pointSize: size, weight: .semibold, scale: .large)
        let buttonImage = UIImage(systemName: imageName, withConfiguration: configuration)
        let buttonWithColor = buttonImage!.withTintColor(color, renderingMode: .alwaysOriginal)
        self.setImage(buttonWithColor, for: .normal)
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backgroundColor
        if let color = shadowColor {
            self.addShadow(color: color)
        }
        if let radius = cornerRadius {
            self.layer.cornerRadius = radius
        }
    }
    
    init(title: String, color: UIColor, cornerRadius: CGFloat) {
        super.init(frame: .zero)
        self.backgroundColor = color
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
    
    init(title: String, textColor: UIColor, textSize: CGFloat, textWeight: UIFont.Weight) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.setTitle(title, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: textSize, weight: textWeight)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


