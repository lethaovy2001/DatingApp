//
//  IconButton.swift
//  DatingApp
//
//  Created by Vy Le on 2/20/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class IconButton: UIButton {
    
    init(systemName: String) {
        super.init(frame: .zero)
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let buttonImage = UIImage(systemName: systemName, withConfiguration: configuration)
        self.setImage(buttonImage, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
