//
//  TapGestureDelegate.swift
//  DatingApp
//
//  Created by Vy Le on 4/23/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

protocol TapGestureDelegate {
    func didTap()
    func setImage(image: UIImage)
}

extension TapGestureDelegate {
    func didTap() {
        print("Did Tap...")
    }
    
    func setImage(image: UIImage) {
        print("Set Image...")
    }
}
