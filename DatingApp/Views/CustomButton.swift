//
//  CustomButton.swift
//  DatingApp
//
//  Created by Vy Le on 1/21/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    init(imageName: String, size: CGFloat, color: UIColor, cornerRadius: CGFloat?, shadowColor: UIColor?) {
        super.init(frame: .zero)
        let configuration = UIImage.SymbolConfiguration(pointSize: size, weight: .black, scale: .large)
        let buttonImage = UIImage(systemName: imageName, withConfiguration: configuration)
        let buttonWithColor = buttonImage!.withTintColor(color, renderingMode: .alwaysOriginal)
        self.setImage(buttonWithColor, for: .normal)
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        if let color = shadowColor {
            self.addShadow(color: color)
            self.backgroundColor = .white
        }
        if let radius = cornerRadius {
            self.layer.cornerRadius = radius
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


